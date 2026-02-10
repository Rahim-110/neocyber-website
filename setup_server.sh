#!/bin/bash

# NeoCyber/FutCare Cloud Deployment Script

# 1. Update and Install Nginx
echo "Installing Nginx..."
sudo apt-get update
sudo apt-get install -y nginx

# 2. Setup Directory Permissions
echo "Setting permissions..."
# Ensure the user home is accessible (default is often restricted in some AMIs)
sudo chmod 755 /home/ubuntu
# Create destination if it doesn't exist (though you should unzip here)
sudo mkdir -p /home/ubuntu/website
# Set strict ownership and read/execute permissions
sudo chown -R ubuntu:ubuntu /home/ubuntu/website
sudo chmod -R 755 /home/ubuntu/website

# 3. Configure Nginx
echo "Configuring Nginx..."
# Remove default config to prevent duplicate server blocks
sudo rm -f /etc/nginx/sites-enabled/default
sudo rm -f /etc/nginx/sites-enabled/default.bak

# Write new config
# We use tee to write to the file with sudo privileges
sudo tee /etc/nginx/sites-enabled/default > /dev/null <<EOL
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /home/ubuntu/website;
    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOL

# 4. Reload Nginx
echo "Reloading Nginx..."
sudo nginx -t
sudo systemctl reload nginx

echo "Deployment configuration complete! Your site should be live."
