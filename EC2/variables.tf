variable "aws_region" {
  default = "us-east-1"
}

variable "ami_id" {
  default = "ami-0f9de6e2d2f067fca"  # Ubuntu 22.04 LTS (Change if needed)
}

variable "instance_type" {
  default = "t3.micro"
}

variable "ssh_key" {
  description = "Path to SSH public key"
  default     = "~/.ssh/deployer_key.pub"
}
