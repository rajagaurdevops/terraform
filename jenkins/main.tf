provider "aws" {
  region = "us-east-1"  # AWS region where resources will be deployed
}

resource "aws_instance" "web" {
  ami           = "ami-04b4f1a9cf54c11d0"  # Amazon Machine Image (Ubuntu 22.04 LTS)
  instance_type = "t3.micro"  # EC2 instance type
  key_name      = "hp"  # SSH key for access

  vpc_security_group_ids = [aws_security_group.web_sg.id]  # Attach security group to instance

  user_data = <<-EOF
              #!/bin/bash
              set -ex  

              # Update system
              apt update -y
              apt upgrade -y
              sleep 10  

              # Install Nginx
              apt install -y nginx
              systemctl enable nginx  
              systemctl restart nginx  

              # Install Java
              apt install -y openjdk-17-jdk

              # Add Jenkins repository and key
              curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | tee \
                /usr/share/keyrings/jenkins-keyring.asc > /dev/null

              echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
                https://pkg.jenkins.io/debian binary/" | tee \
                /etc/apt/sources.list.d/jenkins.list > /dev/null

              # Install Jenkins
              apt update
              apt install -y jenkins
              
              systemctl daemon-reload  
              systemctl enable jenkins  
              systemctl restart jenkins  

              sleep 10
              
              # Get instance public IP dynamically
              INSTANCE_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

              # Configure Nginx as a reverse proxy for Jenkins
              cat <<EOF2 > /etc/nginx/sites-available/jenkins
              server {
                  listen 80;
                  server_name \$INSTANCE_IP;

                  location / {
                      proxy_pass http://localhost:8080;
                      proxy_set_header Host \$host;
                      proxy_set_header X-Real-IP \$remote_addr;
                      proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
                      proxy_set_header X-Forwarded-Proto \$scheme;
                  }
              }
              EOF2

              # Enable the Jenkins site and restart Nginx
              ln -s /etc/nginx/sites-available/jenkins /etc/nginx/sites-enabled/
              rm -f /etc/nginx/sites-enabled/default
              nginx -t
              systemctl restart nginx


              # Output Jenkins initial password
              cat /var/lib/jenkins/secrets/initialAdminPassword
              EOF

  tags = {
    Name = "Terraform-EC2-Nginx-Jenkins"  # Tagging the instance for easy identification
  }
}

resource "aws_security_group" "web_sg" {
  name        = "web-sg-test"
  description = "Allow SSH, HTTP, HTTPS"

  ingress {
    from_port   = 22  # Allow SSH access
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 80  # Allow HTTP access
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443  # Allow HTTPS access
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

  egress {
    from_port   = 0  # Allow all outbound traffic
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "instance_public_ip" {
  value = aws_instance.web.public_ip  # Output the public IP of the instance
}

output "jenkins_url" {
  value = "http://${aws_instance.web.public_ip}"  # Output Jenkins URL (No need for :8080)
}

output "nginx_url" {
  value = "http://${aws_instance.web.public_ip}"  # Output Nginx URL
}
