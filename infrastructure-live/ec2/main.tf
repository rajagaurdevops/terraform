# ----------------------------------------------------
# Use VPC module from another GitHub repo
# ----------------------------------------------------
module "vpc" {
  source = source = "git::https://github.com/rajagaurdevops/terraform-modules.git//vic-module?ref=main"

  vpc_name            = var.vpc_name
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zone   = var.availability_zone
  tags                = var.tags
}

# ----------------------------------------------------
# EC2 Instance in Public Subnet
# ----------------------------------------------------
resource "aws_instance" "web_server" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = module.vpc.public_subnet_id
  associate_public_ip_address  = true

  tags = merge(
    var.tags,
    {
      Name = "web-server-instance"
    }
  )
}
