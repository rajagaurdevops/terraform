# =============================================
# Security Group for EKS Worker Nodes
# =============================================
resource "aws_security_group" "node_sg" {
  name        = "eks-node-sg"
  description = "Security group for EKS worker nodes"
  vpc_id      = aws_vpc.eks_vpc.id   # must reference the VPC

  # Allow SSH from anywhere (optional, adjust for security)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all traffic within the security group (node-to-node communication)
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    self            = true
  }


  # ===========================
  # Outbound Rules
  # ===========================
  # Allow all outbound traffic to internet (for updates, Docker images)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-node-sg"
  }
}
