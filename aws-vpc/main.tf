terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.54.1"
    }
  }
}

provider "aws" {
    region = "us-east-1"
}

# Define a VPC with a CIDR block of 10.0.0.0/16
resource "aws_vpc" "hp-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "terraform-vpc"
    }
}

# Define a private subnet within the VPC
resource "aws_subnet" "private-subnet" {
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    vpc_id = aws_vpc.hp-vpc.id
    tags = {
      Name = "private-subnet"
    }
}

# Define a public subnet within the VPC
resource "aws_subnet" "public-subnet" {
  cidr_block = "10.0.2.0/24"
  vpc_id     = aws_vpc.hp-vpc.id
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true # Assign a public IP to instances in this subnet
  tags = {
    Name = "public-subnet"
  }
}

# Create an Internet Gateway to enable internet access
resource "aws_internet_gateway" "hp-igw" {
  vpc_id = aws_vpc.hp-vpc.id
  tags = {
    Name = "hp-igw"
  }
}

# Create a public route table to route traffic to the internet
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.hp-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hp-igw.id # Default route to the internet
  }

  tags = {
    Name = "public-route-table"
  }
}

# Associate the public subnet with the public route table
resource "aws_route_table_association" "public-subnet" {
  route_table_id = aws_route_table.public-rt.id 
  subnet_id      = aws_subnet.public-subnet.id
}

# Launch an EC2 instance in the public subnet
resource "aws_instance" "myserver" {
  ami                    = "ami-04b4f1a9cf54c11d0" # Amazon Machine Image ID
  instance_type          = "t3.micro" # Instance type
  key_name               = "hp"  # Ensure this key pair exists in AWS
  subnet_id              = aws_subnet.public-subnet.id

  tags = {
    Name = "terraformec2-vpc"
  }
}
