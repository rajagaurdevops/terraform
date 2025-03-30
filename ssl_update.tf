# resource "null_resource" "ssl_update" {
#   depends_on = [aws_instance.web]

#   provisioner "remote-exec" {
#     connection {
#       type        = "ssh"
#       user        = "ubuntu"
#       private_key = file("/home/ubuntu/.ssh/id_rsa")
#       host        = aws_instance.web.public_ip
#     }

#     inline = [
#       "sudo apt update -y",
#       "sudo apt install -y certbot python3-certbot-nginx",
#       "sudo certbot --nginx -d jenkins.vishnugaur.com --non-interactive --agree-tos -m rajagaur333@gmail.com --redirect",
#       "sudo systemctl restart nginx"
#     ]
#   }
# }
