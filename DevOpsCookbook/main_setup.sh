#!/bin/bash
# main_setup.sh - Main script to start the overall setup.

# Function to handle errors
handle_error() {
    echo "Error: $1"
    exit 1
}

# Make the scripts executable
echo "Making all scripts executable..."
chmod +x make_scripts_executable.sh || handle_error "Failed to change permissions for make_scripts_executable.sh"

# Run the script to make other scripts executable
./make_scripts_executable.sh || handle_error "Failed to run make_scripts_executable.sh"

# Example Docker command (ensure Docker is running)
echo "Checking Docker containers..."
docker ps || handle_error "Docker command failed. Please ensure Docker is running."

# Proceed with the Docker setup
echo "Starting the Docker setup..."
./DockerSetup/docker_setup.sh || handle_error "Docker setup failed."

# Add more setup steps as needed
