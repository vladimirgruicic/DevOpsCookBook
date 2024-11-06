#!/bin/bash
# main_setup.sh - Main script to start the overall setup.

# Function to handle errors
handle_error() {
    echo "Error: $1"
    echo "Current directory: $(pwd)"
    exit 1
}

# Step 1: Check if Python is installed
echo "Checking if Python is installed..."
if ! command -v python3 &> /dev/null; then
    echo "Python is not installed. Installing Python..."
    if ! sudo apt-get update || ! sudo apt-get install -y python3 python3-pip; then
        handle_error "Failed to install Python. Please install Python manually and retry."
    fi
    echo "Python installed successfully."
else
    echo "Python is already installed."
fi

# Step 2: Install Docker SDK for Python
echo "Checking if Python Docker SDK is installed..."
if ! python3 -c "import docker" &> /dev/null; then
    echo "Docker SDK for Python is not installed. Installing..."
    if ! pip3 install docker; then
        handle_error "Failed to install Docker SDK for Python. Please install it manually and retry."
    fi
    echo "Docker SDK for Python installed successfully."
else
    echo "Docker SDK for Python is already installed."
fi

# Step 3: Make the scripts executable
echo "Making all scripts executable..."
chmod +x make_scripts_executable.sh || handle_error "Failed to change permissions for make_scripts_executable.sh"

# Run the script to make other scripts executable
echo "Executing: ./make_scripts_executable.sh"
./make_scripts_executable.sh || handle_error "Failed to run make_scripts_executable.sh"

# Step 4: Check Docker status and verify it is running
echo "Checking Docker status..."
if ! docker info > /dev/null 2>&1; then
    handle_error "Docker is not running. Please start Docker before continuing."
fi

# Step 5: Proceed with the Docker setup
echo "Starting the Docker setup..."
./DockerSetup/docker_setup.sh || handle_error "Docker setup failed."

echo "Main setup completed successfully."
