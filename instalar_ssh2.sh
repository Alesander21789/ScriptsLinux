#!/bin/bash

echo "Starting SSH installation and configuration..."

# Check if root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root."
  exit 1
fi

# Prompt for SSH port
echo -n "Enter the desired SSH port (default 22): "
read ssh_port

# Set default SSH port if not provided
if [ -z "$ssh_port" ]; then
  ssh_port=22
fi

# Prompt for root login permission
echo -n "Allow root login? (y/n, default n): "
read root_login

# Set default root login permission if not provided
if [ -z "$root_login" ]; then
  root_login="n"
fi

# Prompt for allowing only one user to connect to SSH
echo -n "Allow only one user to connect to SSH? (y/n, default n): "
read restrict_user

# Set default restriction to multiple users if not provided
if [ -z "$restrict_user" ]; then
  restrict_user="n"
fi

# If only one user is allowed to connect to SSH, prompt for the username
if [ "$restrict_user" = "y" ]; then
  echo -n "Enter the username: "
  read ssh_user
fi

# Install SSH
apt-get update
apt-get install openssh-server -y

# Backup original SSH config
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# Configure SSH
sed -i "s/#Port 22/Port $ssh_port/g" /etc/ssh/sshd_config
if [ "$root_login" = "y" ]; then
  sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
else
  sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin no/g" /etc/ssh/sshd_config
fi

# Enable key-based authentication
sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config
sed -i "s/#PubkeyAuthentication yes/PubkeyAuthentication yes/g" /etc/ssh/sshd_config

# If only one user is allowed to connect to SSH, add AllowUsers configuration
if [ "$restrict_user" = "y" ]; then
  echo "AllowUsers $ssh_user" >> /etc/ssh/sshd_config
fi

# Restart SSH
systemctl restart ssh

echo "SSH installation and configuration complete!"