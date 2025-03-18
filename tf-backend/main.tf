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
    region = "us-east-1"                     # AWS region where the bucket is located
  }
}

# Configuring the AWS provider
provider "aws" {
  region = "us-east-1"  # Specifying the AWS region for resource creation
}

# Defining an EC2 instance resource
resource "aws_instance" "myserver" {
  instance_type = "t3.micro"                 # Selecting instance type
  ami           = "ami-04b4f1a9cf54c11d0"    # Specifying the AMI ID for the instance
  key_name      = "hp"                       # Defining the key pair for SSH access

  # Assigning tags to the instance
  tags = {
    Name = "terraformec2"  # Labeling the instance with a name tag
  }
}
