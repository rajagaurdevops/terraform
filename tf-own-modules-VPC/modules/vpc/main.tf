# Create a VPC with the CIDR block and name passed from the input variable
resource "aws_vpc" "main" {
  cidr_block = var.vpc_config.cidr_block  # The CIDR block for the VPC
  tags = {
    Name = var.vpc_config.name  # Name of the VPC
  }
}

# Create subnets within the VPC based on the subnet configuration
resource "aws_subnet" "main" {
  vpc_id = aws_vpc.main.id  # Associate the subnet with the VPC
  for_each = var.subnet_config  # Loop over subnet configuration to create subnets

  cidr_block        = each.value.cidr_block  # CIDR block for the subnet
  availability_zone = each.value.AZ  # Availability Zone for the subnet

  tags = {
    Name = each.key  # Name of the subnet (key from subnet_config)
  }
}

# Create a local variable to hold public subnets only
locals {
  public_subnet = {
    for key, config in var.subnet_config : key => config if config.public
  }
}

# Create an Internet Gateway and attach it to the VPC if there are public subnets
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id  # Associate the Internet Gateway with the VPC
  count = length(local.public_subnet) > 0 ? 1 : 0  # Create the IGW only if there are public subnets
}

# Create a Route Table for the public subnet with a default route to the Internet Gateway
resource "aws_route_table" "main" {
  count   = length(local.public_subnet) > 0 ? 1 : 0  # Only create a route table if there are public subnets
  vpc_id  = aws_vpc.main.id  # Associate the route table with the VPC

  route {
    cidr_block  = "0.0.0.0/0"  # Default route for all traffic
    gateway_id  = aws_internet_gateway.main[count.index].id  # Set the gateway to the Internet Gateway ID
  }
}

# Associate the route table with the public subnets
resource "aws_route_table_association" "main" {
  for_each = local.public_subnet  # Iterate over the public subnets

  subnet_id      = aws_subnet.main[each.key].id  # Associate each public subnet with the route table
  route_table_id = aws_route_table.main[0].id  # Use the first route table created
}
