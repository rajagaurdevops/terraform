variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for Ubuntu"
  default     = "ami-04b4f1a9cf54c11d0"
}

variable "key_name" {
  description = "SSH key name"
  default     = "hp"
}
