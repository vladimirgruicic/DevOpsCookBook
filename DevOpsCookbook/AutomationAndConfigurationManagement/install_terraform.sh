#!/bin/bash
# install_terraform.sh - Script to install Terraform on a Linux system

# Define Terraform version
TERRAFORM_VERSION="1.5.0"

# Update package manager and install necessary dependencies
echo "Updating package manager..."
sudo apt-get update

# Install Terraform
echo "Downloading Terraform..."
curl -LO "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
echo "Unzipping Terraform..."
unzip "terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
echo "Moving Terraform binary to /usr/local/bin..."
sudo mv terraform /usr/local/bin/
rm "terraform_${TERRAFORM_VERSION}_linux_amd64.zip" # Cleanup

# Verify installation
terraform version

echo "Terraform has been installed successfully."
