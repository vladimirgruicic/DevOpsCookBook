#!/bin/bash
# docker_setup.sh - Main setup script for Docker, which installs, configures Docker, and creates containers.

# Function to handle errors
handle_error() {
    echo "Error: $1"
    exit 1
}

# Base directory for the scripts
BASE_DIR="$(pwd)/DockerSetup"

# Step 1: Install Docker
echo "Executing: $BASE_DIR/install_docker.sh"
"$BASE_DIR/install_docker.sh" > >(tee -a install_docker.log) 2>&1 || handle_error "Docker installation failed."

# Step 2: Configure Docker
echo "Executing: $BASE_DIR/configure_docker.sh"
"$BASE_DIR/configure_docker.sh" > >(tee -a configure_docker.log) 2>&1 || handle_error "Docker configuration failed."

# Step 3: Create Docker containers
echo "Executing: $BASE_DIR/create_docker_container.sh"
"$BASE_DIR/create_docker_container.sh" > >(tee -a create_docker_container.log) 2>&1 || handle_error "Docker container creation failed."

echo "Docker installation, configuration, and container creation completed successfully."
