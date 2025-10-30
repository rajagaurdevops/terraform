output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC ID from module"
}

output "public_subnet_id" {
  value       = module.vpc.public_subnet_id
  description = "Public subnet ID"
}

output "ec2_public_ip" {
  value       = aws_instance.web_server.public_ip
  description = "EC2 instance public IP"
}

output "current_account_id" {
  value = data.aws_caller_identity.current.account_id
}
