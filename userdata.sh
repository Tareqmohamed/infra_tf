#!/bin/bash
 
# Update package lists
sudo apt update
 
# Install Nginx
sudo apt install -y nginx
 
# Fetch the public IP address
PUBLIC_IP=$(curl -s http://checkip.amazonaws.com)
 
# Create an HTML page with the public IP
echo "<html>
<head>
<title>Hello from Nginx</title>
</head>
<body>
<h1>Hello! Your Public IP is: $PUBLIC_IP</h1>
</body>
</html>" | sudo tee /var/www/html/index.nginx-debian.html
 
# Restart Nginx to apply the changes
sudo systemctl restart nginx
 
# Display the IP and service status
echo "Nginx installed. Your public IP is: $PUBLIC_IP"
sudo systemctl status nginx