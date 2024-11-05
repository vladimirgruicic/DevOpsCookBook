#!/bin/bash
# configure_docker.sh - Configures Docker to be used without sudo.

# Function to handle errors
handle_error() {
    echo "Error: $1"
    exit 1
}

# Create a logs directory if it doesn’t exist
mkdir -p logs

{
    echo "Creating the docker group (if not exists)..."
    sudo groupadd docker

    # Check if the current user is already in the docker group
    if groups $USER | grep &>/dev/null '\bdocker\b'; then
        echo "$USER is already in the docker group."
    else
        echo "Adding the current user to the docker group..."
        sudo usermod -aG docker $USER || handle_error "Failed to add user to docker group."
        echo "Docker configured. Please log out and log back in to apply changes."
    fi
} | tee logs/configure_docker.log
