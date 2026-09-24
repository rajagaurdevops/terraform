output "key_pair_id" {
  description = "The key pair ID."
  value       = aws_key_pair.key_pair.id
}

output "key_pair_name" {
  description = "The key pair name."
  value       = aws_key_pair.key_pair.key_name
}

output "key_pair_arn" {
  description = "The key pair ARN."
  value       = aws_key_pair.key_pair.arn
}
