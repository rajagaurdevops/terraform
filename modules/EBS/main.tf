resource "aws_ebs_volume" "dev-ebs" {
  availability_zone = "us-east-1a"
  size              = 10
  type              = "gp3"
  encrypted         = true
}

output "ebs_volume_id" {
  value = aws_ebs_volume.dev-ebs.id
}