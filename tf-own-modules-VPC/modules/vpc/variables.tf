# Variable to configure the VPC's CIDR block and name
variable "vpc_config" {
  description = "To get the CIDR and name of VPC from user"  # Description of the variable
  type = object({  # Defining the type as an object with two attributes: cidr_block and name
    cidr_block = string  # CIDR block for the VPC (e.g., 10.0.0.0/16)
    name       = string  # Name of the VPC
  })
}

# Variable to configure the subnets within the VPC
variable "subnet_config" {
  description = "Get the CIDR and AZ for the subnet"  # Description of the variable
  type = map(object({  # Defining the type as a map of objects for each subnet
    cidr_block = string  # CIDR block for the subnet (e.g., 10.0.0.0/24)
    AZ         = string  # Availability Zone for the subnet (e.g., us-east-1a)
    public     = optional(bool, false)  # Optional boolean flag to mark the subnet as public (default is false)
  }))
}
