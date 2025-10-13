# =============================================
# IAM Role for EKS Cluster (Master nodes)
# =============================================
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"

  # Trust relationship allowing EKS service to assume this role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"  # EKS cluster can assume this role
        }
      }
    ]
  })
}

# Attach AWS managed policy for EKS cluster operations
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

# =============================================
# IAM Role for Node Group (EC2 Worker nodes)
# =============================================
resource "aws_iam_role" "eks_node_role" {
  name = "eks-node-role"

  # Trust relationship allowing EC2 instances to assume this role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"  # EC2 nodes can assume this role
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach AmazonEKSWorkerNodePolicy to allow nodes to join cluster
resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# Attach AmazonEKS_CNI_Policy to allow nodes to manage networking (CNI plugin)
resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

# Attach AmazonEC2ContainerRegistryReadOnly policy to allow nodes to pull Docker images from ECR
resource "aws_iam_role_policy_attachment" "ec2_container_registry_read_only" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
