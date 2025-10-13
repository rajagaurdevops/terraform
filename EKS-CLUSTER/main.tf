# =============================================
# Create EKS Cluster
# =============================================
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name

  # IAM Role ARN for the EKS control plane (master nodes)
  # This role allows the EKS cluster to manage AWS resources
  role_arn = aws_iam_role.eks_cluster_role.arn

  # VPC configuration for the cluster
  vpc_config {
    # Subnets where the control plane will communicate with worker nodes
    subnet_ids = [aws_subnet.eks_subnet_a.id, aws_subnet.eks_subnet_b.id]
  }

  # Ensure that IAM role policies are attached before creating the cluster
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]
}
