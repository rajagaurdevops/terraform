# Provide isolated virtual network for your EKS cluster
# =============================================
# Create a VPC for EKS Cluster
# =============================================
resource "aws_vpc" "Eks_vpc" {
  cidr_block           = "10.0.0.0/16"       # Define IP range for the VPC
  enable_dns_support   = true                # Enable DNS resolution in the VPC
  enable_dns_hostnames = true                # Enable DNS hostnames for EC2 instances
  tags = {
    Name = "Eks-vpc"
  }
}


# Divide VPC into multiple availability zones for high availability.
# Need: EKS requires at least two subnets in different AZs for fault tolerance
# ---------------------------------------------
# Public Subnet in Availability Zone A
# ---------------------------------------------
resource "aws_subnet" "Eks_subnet_a" {
  vpc_id            = aws_vpc.eks_vpc.id       # Associate with VPC created above
  cidr_block        = "10.0.1.0/24"           # IP range for this subnet
  availability_zone = "${var.aws_region}a"    # Deploy in specific AZ
  tags = {
    Name = "Eks-subnet-a"
  }
}


# ---------------------------------------------
# Public Subnet in Availability Zone B
# ---------------------------------------------
resource "aws_subnet" "Eks_subnet_b" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.aws_region}b"
  tags = {
    Name = "Eks-subnet-b"
  }
}


# Provides internet access to nodes in public subnets.
# Need: EC2 nodes need internet to download packages, pull container images, etc.
# ---------------------------------------------
# Internet Gateway for public subnets
# ---------------------------------------------
resource "aws_internet_gateway" "Eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id
  tags = {
    Name = "Eks-igw"
  }
}

# ---------------------------------------------
# Route Table to route traffic to Internet
# ---------------------------------------------
resource "aws_route_table" "Eks_route_table" {
  vpc_id = aws_vpc.eks_vpc.id

  # Default route for all internet traffic
  route {
    cidr_block = "0.0.0.0/0"                 # Send all traffic to IGW
    gateway_id = aws_internet_gateway.eks_igw.id
  }

  tags = {
    Name = "Eks-route-table"
  }
}


# Controls routing of traffic from subnets to IGW (internet).
# Need: Without route table, nodes cannot access the internet
# ---------------------------------------------
# Associate Subnet A with Route Table
# ---------------------------------------------
resource "aws_route_table_association" "subnet_a_assoc" {
  subnet_id      = aws_subnet.eks_subnet_a.id
  route_table_id = aws_route_table.eks_route_table.id
}


# Links subnets to route table so they use the defined routes.
# Need: Ensures subnets actually have internet connectivity
# ---------------------------------------------
# Associate Subnet B with Route Table
# ---------------------------------------------
resource "aws_route_table_association" "subnet_b_assoc" {
  subnet_id      = aws_subnet.eks_subnet_b.id
  route_table_id = aws_route_table.eks_route_table.id
}

