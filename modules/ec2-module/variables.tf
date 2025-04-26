variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}


variable "instance_name" {
  description = "Tag name for the instance"
  type        = string
}

variable "instance_key" {
    description = "Thia ia Already exit key "
    type = string
}

variable "security_group_id" {
  description = "Security Group ID to attach to the EC2 instance"
  type        = string
}

