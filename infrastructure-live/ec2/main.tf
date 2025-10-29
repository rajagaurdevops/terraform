
provider "aws" {
  region = var.region
}

resource "aws_instance" "myserver" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name  # Ensure this key pair exists in AWS
  vpc_security_group_ids = var.vpc_security_group_ids 

  tags = {
    Name = "terraformec2"
  }
}
