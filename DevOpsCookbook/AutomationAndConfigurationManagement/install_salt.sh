#!/bin/bash
# install_salt.sh - Script to install SaltStack (Salt) on a Linux system

# Update package manager and install necessary dependencies
echo "Updating package manager..."
sudo apt-get update

# Install Salt Master and Salt Minion
echo "Installing Salt..."
sudo apt-get install -y salt-master salt-minion

# Start Salt services
echo "Starting Salt services..."
sudo systemctl start salt-master
sudo systemctl start salt-minion

# Enable Salt services to start on boot
sudo systemctl enable salt-master
sudo systemctl enable salt-minion

# Verify installation
salt --version

echo "SaltStack has been installed successfully."
