#!/bin/bash
# main_setup.sh - Main script to install, configure Docker, and create containers

# Function to handle errors
handle_error() {
    echo "Error: $1"
    exit 1
}

# Run the Docker installation script
echo "Starting Docker installation..."
bash install_docker.sh || handle_error "Docker installation failed."

# Run the Docker configuration script
echo "Configuring Docker..."
bash configure_docker.sh || handle_error "Docker configuration failed."

# Run the Docker container creation script
echo "Creating Docker containers from image list..."
bash create_docker_container.sh || handle_error "Docker container creation failed."

echo "Docker installation, configuration, and container creation completed successfully."
