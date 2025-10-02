#!/bin/bash
set -ex  # Debugging enable karein aur error pe script stop ho jaye

# System update aur upgrade
apt update -y && apt upgrade -y

# Required packages install karein
apt install -y curl nginx openjdk-17-jdk

# Nginx enable aur restart karein
systemctl enable nginx  
systemctl restart nginx  

# Jenkins ke liye repo aur key add karein
mkdir -p /usr/share/keyrings  
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null  

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/" | tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null  

# Update aur Jenkins install karein
apt update -y
apt install -y jenkins

# Jenkins service enable aur restart karein
systemctl daemon-reload  
systemctl enable jenkins  
systemctl restart jenkins  

# Nginx ke reverse proxy configuration karein
cat <<EOF > /etc/nginx/sites-available/default
server {
    listen 80;
    server_name localhost;

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

# Nginx configuration enable karein aur restart karein
ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
nginx -t  
systemctl restart nginx
