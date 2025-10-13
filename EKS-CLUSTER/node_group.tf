resource "aws_eks_node_group" "eks_node_group" {
  # Name of the EKS cluster to attach this node group
  cluster_name    = aws_eks_cluster.eks_cluster.name
  
  # Name of the Node Group
  node_group_name = var.node_group_name
  
  # IAM Role ARN for EC2 worker nodes
  node_role_arn   = aws_iam_role.eks_node_role.arn
  
  # Subnets where nodes will be launched (usually private subnets)
  subnet_ids      = [aws_subnet.eks_subnet_a.id, aws_subnet.eks_subnet_b.id]

  # Node Group scaling configuration
  scaling_config {
    desired_size = var.desired_capacity
    max_size     = var.max_size
    min_size     = var.min_size
  }

  # EC2 instance types for nodes
  instance_types = [var.node_instance_type]

  # Root volume size in GB for each node (default 20 GB)
  disk_size = 10

  # Kubernetes node labels (used for scheduling pods, monitoring, and grouping nodes)
  # labels = {
  #   environment = "prod"
  #   team        = "devops"
  # }

  # Node taints (prevent pods from scheduling unless tolerations exist)
  # Uncomment if you want to isolate nodes for special workloads
  # taints = [
  #   {
  #     key    = "dedicated"
  #     value  = "gpu"
  #     effect = "NO_SCHEDULE"
  #   }
  # ]

  # Remote access settings for SSH
  remote_access {
    ec2_ssh_key = var.ssh_key_name               # SSH key name for accessing nodes
    source_security_group_ids = [aws_security_group.node_sg.id] # SG allowing SSH
  }

  # AMI type for the worker nodes
  # AL2_x86_64 = Amazon Linux 2 (default and recommended)
  # ami_type = "AL2_x86_64"

  # Capacity type for nodes
  # ON_DEMAND = regular EC2 instances
  # SPOT = lower cost, preemptible instances
  capacity_type = "ON_DEMAND"

  # Tags to help identify and organize AWS resources
  tags = {
    Name        = "${var.node_group_name}-node"
    Environment = "production"
  }

  # Ensure that the EKS cluster is created before creating the node group
  depends_on = [aws_eks_cluster.eks_cluster]
}
