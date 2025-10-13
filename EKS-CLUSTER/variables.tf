# AWS Region where the EKS cluster will be created
variable "aws_region" {
  description = "AWS Region for EKS Cluster"
  default     = "ap-south-1"
}

# Name of the EKS cluster
variable "cluster_name" {
  description = "Name of the EKS Cluster"
  default     = "test-Eks-cluster"
}

# Name of the Node Group
variable "node_group_name" {
  description = "Name of the EKS Node Group"
  default     = "test-Eks-nodes"
}

# EC2 instance type for worker nodes
variable "node_instance_type" {
  description = "EC2 Instance Type for Worker Nodes"
  default     = "t3.micro"
}

# Desired number of worker nodes
variable "desired_capacity" {
  description = "Desired number of worker nodes"
  default     = 1
}

# Minimum number of worker nodes in the Node Group
variable "min_size" {
  description = "Minimum number of worker nodes"
  default     = 1
}

# Maximum number of worker nodes in the Node Group
variable "max_size" {
  description = "Maximum number of worker nodes"
  default     = 3
}

# Name of the SSH key pair for accessing worker nodes
variable "ssh_key_name" {
  description = "SSH Key Pair Name for EC2 Instances"
  default     = "Eks-keypair"
}
