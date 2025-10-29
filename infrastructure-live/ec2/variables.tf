variable "region" {
    description = "The value of Region"
    type = string
    default = "us-east-1"
  
}

variable "instance_type" {
    description = "Ec2 instance type"
    default = "t3.micro"
  
}

variable "ami" {
    description = "AMI ID for EC2 instance"
    default = "ami-04b4f1a9cf54c11d0"
  
}

variable "key_name" {
    description = " Already exiting key pair"
    default = "hp"
  
}

variable "vpc_security_group_ids" {
    description = " value of security group"
    default = ["sg-0be11f9d07ee34fdd"]
}
