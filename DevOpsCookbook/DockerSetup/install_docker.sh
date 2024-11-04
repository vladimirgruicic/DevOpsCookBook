#!/bin/bash
# install_docker.sh - Installs Docker on Ubuntu with error handling.

# Function to handle errors
handle_error() {
    echo "Error: $1"
    exit 1
}

# Check if Docker is already installed
if command -v docker &> /dev/null; then
    echo "Docker is already installed. Version: $(docker --version)"
    exit 0
fi

echo "Updating package index..."
sudo apt-get update -y || handle_error "Failed to update package index."

echo "Installing prerequisites..."
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common || handle_error "Failed to install prerequisites."

echo "Adding Docker’s official GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg || handle_error "Failed to add Docker GPG key."

echo "Adding Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null || handle_error "Failed to add Docker repository."

echo "Updating package index again..."
sudo apt-get update -y || handle_error "Failed to update package index."

echo "Installing Docker..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io || handle_error "Failed to install Docker."

echo "Docker installation complete!"
docker --version
