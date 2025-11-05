# =============================================
# EKS Cluster & Node Group Outputs
# =============================================

# Useful for referencing cluster name in other modules or scripts
output "cluster_name" {
  description = "Name of the EKS Cluster"
  value       = aws_eks_cluster.eks_cluster.name
}

# This is the API server endpoint (used by kubectl to connect)
output "cluster_endpoint" {
  description = "EKS Cluster API Server Endpoint"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

# Amazon Resource Name for the EKS cluster (useful for IAM references or automation)
output "cluster_arn" {
  description = "ARN of the EKS Cluster"
  value       = aws_eks_cluster.eks_cluster.arn
}

# Displays the name of the node group created in this setup
output "node_group_name" {
  description = "Name of the EKS Node Group"
  value       = aws_eks_node_group.eks_node_group.node_group_name
}
