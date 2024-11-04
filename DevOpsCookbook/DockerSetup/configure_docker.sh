#!/bin/bash
# configure_docker.sh - Configures Docker to be used without sudo.

echo "Creating the docker group (if not exists)..."
sudo groupadd docker

echo "Adding the current user to the docker group..."
sudo usermod -aG docker $USER

echo "Docker configured. Please log out and log back in to apply changes."
