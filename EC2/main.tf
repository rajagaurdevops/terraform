provider "aws" {
  region = "us-east-1"  # Change to your preferred AWS region
}

# 🚀 1. Create a Key Pair
resource "aws_key_pair" "my_key" {
  key_name   = "terraform_key"
  public_key = file("~/.ssh/id_rsa.pub")  # Ensure you have a valid SSH key here
}

# 🚀 2. Create a Security Group
resource "aws_security_group" "nginx_sg" {
  name        = "nginx-security-group"
  description = "Allow SSH and HTTP access"

  # Allow SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 🚀 3. Launch EC2 Instance & Install Nginx
resource "aws_instance" "nginx_server" {
  ami                    = "ami-0e783882a19958fff"  # Amazon Linux 2 (Change as needed)
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.my_key.key_name
  security_groups        = [aws_security_group.nginx_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  tags = {
    Name = "NginxServer"
  }
}

# 🚀 4. Output Public IP of the Instance
output "nginx_server_ip" {
  value = aws_instance.nginx_server.public_ip
}
