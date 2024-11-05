#!/bin/bash
# main_setup.sh - Main script to start the overall setup.

# Function to handle errors
handle_error() {
    echo "Error: $1"
    echo "Current directory: $(pwd)"
    exit 1
}

# Make the scripts executable
echo "Making all scripts executable..."
chmod +x make_scripts_executable.sh || handle_error "Failed to change permissions for make_scripts_executable.sh"

# Run the script to make other scripts executable
echo "Executing: ./make_scripts_executable.sh"
./make_scripts_executable.sh || handle_error "Failed to run make_scripts_executable.sh"

# Check Docker status and verify it is running
echo "Checking Docker status..."
if ! docker info > /dev/null 2>&1; then
    handle_error "Docker is not running. Please start Docker before continuing."
fi

# Proceed with the Docker setup
echo "Starting the Docker setup..."
./DockerSetup/docker_setup.sh || handle_error "Docker setup failed."

echo "Main setup completed successfully."
