provider "aws" {
  region = "us-east-1"
}

# Create IAM user
resource "aws_iam_user" "simple_user" {
  name = "simple-user"
}

# Create login profile (password for user)
resource "aws_iam_user_login_profile" "simple_password" {
  user     = aws_iam_user.simple_user.name
  password_length = 12      # Use a secure password in real setups
  password_reset_required = false
}

# Attach EC2 Full Access policy
resource "aws_iam_user_policy_attachment" "ec2_full_access" {
  user       = aws_iam_user.simple_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}
