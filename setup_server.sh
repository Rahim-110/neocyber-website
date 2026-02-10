#!/bin/bash

# NeoCyber/FutCare Cloud Deployment Script

# Configuration
WEB_ROOT="/var/www/html"

# 1. Update and Install Nginx
echo "Installing Nginx..."
sudo apt-get update
sudo apt-get install -y nginx

# 2. Setup Directory Permissions
echo "Setting permissions for $WEB_ROOT..."
# Ensure the directory exists
sudo mkdir -p $WEB_ROOT

# Set ownership to ubuntu (so you can edit files) but allow Nginx to read
sudo chown -R ubuntu:ubuntu $WEB_ROOT
# 755 means read/execute for everyone, write for owner. Nginx needs read/execute.
sudo chmod -R 755 $WEB_ROOT

# 3. Configure Nginx
echo "Configuring Nginx..."
# Remove default config
sudo rm -f /etc/nginx/sites-enabled/default

# Write new config
sudo tee /etc/nginx/sites-enabled/default > /dev/null <<EOL
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root $WEB_ROOT;
    index index.html index.htm;

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
