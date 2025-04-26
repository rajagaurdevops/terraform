provider "aws" {
  region = "us-east-1" 
}

module "ec2_instance" {
  source         = "../../modules/ec2-module"
  ami_id         = "ami-084568db4383264d4" 
  instance_type  = "t3.micro"
  instance_name  = "MyTerraformEC2"
  instance_key = "hp"
  security_group_id = "vpc_security_group_ids"
  
}
