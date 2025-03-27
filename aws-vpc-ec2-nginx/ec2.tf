# EC2 instance For Nginx setup
resource "aws_instance" "nginxserver" {
  ami                         = "ami-04b4f1a9cf54c11d0"
  instance_type               = "t3.micro"
  key_name =                       "hp"
  # Associate the instance with a public subnet
  subnet_id                   = aws_subnet.public-subnet.id
  # Attach the security group for Nginx 
  vpc_security_group_ids      = [aws_security_group.nginx-sg.id]
  # Enable public IP assignment for external access
  associate_public_ip_address = true
# User data script to install and start Nginx on instance launch
  user_data = <<-EOF
            #!/bin/bash
            sudo yum install nginx -y
            sudo systemctl start nginx
            EOF

  tags = {
    Name = "NginxServer"
  }
}