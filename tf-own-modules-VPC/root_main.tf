# AWS provider configuration specifying the region
provider "aws" {
  region = "us-east-1"
}

# Module definition to create VPC and subnets
module "vpc-module" {
  # Path to the module that creates the VPC and related resources
  source = "./modules/vpc"

  # Configuration for the VPC
  vpc_config = {
    cidr_block = "10.0.0.0/16"  # CIDR block for the VPC
    name       = "my-root-vpc"   # Name of the VPC
  }

  # Configuration for subnets within the VPC
  subnet_config = {
    # Public subnet configuration
    public_subnet = {
      cidr_block = "10.0.0.0/24"  # CIDR block for the public subnet
      AZ         = "us-east-1a"    # Availability Zone for the public subnet
      public     = true            # Indicates that this is a public subnet
    }
    
    # Private subnet configuration
    private_subnet = {
      cidr_block = "10.0.1.0/24"  # CIDR block for the private subnet
      AZ         = "us-east-1b"    # Availability Zone for the private subnet
      public     = false           # Indicates that this is a private subnet
    }
  }
}
