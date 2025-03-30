output "instance_public_ip" {
  value = aws_instance.web.public_ip
}

output "jenkins_url" {
  value = "http://${aws_instance.web.public_ip}"
}

output "nginx_url" {
  value = "http://${aws_instance.web.public_ip}"
}
