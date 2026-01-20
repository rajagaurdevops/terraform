terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Configuring remote backend to store the Terraform state file in an S3 bucket
  backend "s3" {
    bucket = "demo-bucket-238e27b63f4d046b"  # Name of the S3 bucket
    key    = "backend.tfstate"               # Path of the state file within the bucket
    region = "us-east-1"                    
  }
}


provider "aws" {
  region = "us-east-1"  
}

# Defining an EC2 instance resource
resource "aws_instance" "myserver" {
  instance_type = "t3.micro"                 
  ami           = "ami-04b4f1a9cf54c11d0"    
  key_name      = "hp"                       

  tags = {
    Name = "terraformec2"  
  }
}
