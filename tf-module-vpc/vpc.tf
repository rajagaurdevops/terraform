# -------------------------------------------------
# Provider Configuration
# -------------------------------------------------
# This tells Terraform to use AWS as the cloud provider
# and specifies the region where resources will be created.
provider "aws" {
  region = "us-east-1"
}

# -------------------------------------------------
# Data Source: Availability Zones
# -------------------------------------------------
# This fetches the list of available availability zones
# in the specified region (us-east-1).
data "aws_availability_zones" "name" {
  state = "available"
}

# -------------------------------------------------
# Module: VPC Creation
# -------------------------------------------------
# Using an official Terraform AWS VPC module
# to create a full VPC setup (subnets, routing, etc.)
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"  # Source of the module from Terraform Registry
  version = "5.21.0"                         # Specific version of the VPC module

  # Basic VPC settings
  name = "test-vpc-module"                   # Name of the VPC
  cidr = "10.0.0.0/16"                       # CIDR block for the VPC (IP range)

  # Subnet settings
  azs = data.aws_availability_zones.name.names # Use the fetched availability zones
  private_subnets = ["10.0.0.0/24"]             # Private subnet CIDR blocks
  public_subnets  = ["10.0.1.0/24"]             # Public subnet CIDR blocks

  # Tags for VPC and related resources
  tags = {
    NAME = "test-vpc-module"
  }
}
