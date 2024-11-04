#!/bin/bash
# package_management.sh

# Update the package index
echo "Updating package index..."
sudo apt update

# Install a sample package (curl)
echo "Installing 'curl'..."
sudo apt install -y curl

# Show installed package
echo "Showing installed package 'curl':"
dpkg -l | grep curl

# Remove the sample package
echo "Removing 'curl'..."
sudo apt remove -y curl

# Clean up unused packages
echo "Cleaning up unused packages..."
sudo apt autoremove -y

# Using yum (if on a Red Hat-based system)
# Uncomment the following if using a system that supports yum
# echo "Installing 'curl' using yum..."
# sudo yum install -y curl
