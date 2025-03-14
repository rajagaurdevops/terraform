variable "aws_region" {
  default = "us-east-1"
}

variable "ami_id" {
  default = "ami-0c55b159cbfafe1f0"  # Ubuntu 22.04 LTS (Change if needed)
}

variable "instance_type" {
  default = "t3.micro"
}

variable "ssh_key" {
  default = "/home/ubuntu/.ssh/authorized_keys"  # Make sure this key exists
}
