# NeoCyber Website

This repository contains the static website files for NeoCyber, restored and ready for deployment.

## Deployment to EC2

### Prerequisites
- An EC2 instance (Ubuntu 22.04 or similar)
- SSH access
- Git installed on EC2

### 1. Connect to EC2
```bash
ssh -i "your-key.pem" ubuntu@34.205.15.143
```

### 2. Clone the Repository
```bash
cd /var/www
sudo git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git html
# OR if /var/www/html already exists:
# sudo rm -rf /var/www/html/*
# sudo git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git /var/www/html
```

### 3. Run Setup Script
The repository includes a helper script to set permissions and basic Nginx config.

```bash
cd /var/www/html
sudo chmod +x setup_server.sh
sudo ./setup_server.sh
```

## Local Development
To view the site locally, simply open `index.html` in your browser.

## Directory Structure
- `index.html`: Main landing page
- `about-us/`, `our-services/`, etc.: Subpages
- `css/`, `js/`, `images/`: Asset directories (remapped from original WordPress structure)
