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

# Step 2: Install pip (if it's not installed)
echo "Checking if pip is installed..."
if ! command -v pip3 &> /dev/null; then
    echo "pip is not installed. Installing pip..."
    if ! sudo apt-get install -y python3-pip; then
        handle_error "Failed to install pip. Please install pip manually and retry."
    fi
    echo "pip installed successfully."
else
    echo "pip is already installed."
fi

# Step 3: Install pytest and docker SDK directly with pip
echo "Installing pytest and docker SDK with pip..."
pip3 install pytest docker || handle_error "Failed to install pytest or docker SDK."

# Step 4: List installed packages
echo "Listing installed packages..."
pip3 list || handle_error "Failed to list installed packages."

# Step 5: Make the scripts executable
echo "Making all scripts executable..."
chmod +x make_scripts_executable.sh || handle_error "Failed to change permissions for make_scripts_executable.sh"

# Run the script to make other scripts executable
if [[ -f make_scripts_executable.sh ]]; then
    echo "Executing: ./make_scripts_executable.sh"
    ./make_scripts_executable.sh || handle_error "Failed to run make_scripts_executable.sh"
else
    handle_error "make_scripts_executable.sh does not exist."
fi

# Step 6: Check Docker status and verify it is running
echo "Checking Docker status..."
if ! docker info > /dev/null 2>&1; then
    handle_error "Docker is not running. Please start Docker before continuing."
fi

# Step 7: Proceed with the Docker setup
echo "Starting the Docker setup..."
./DockerSetup/docker_setup.sh || handle_error "Docker setup failed."

# Step 8: Run the tests to ensure everything is working correctly
echo "Running tests to verify Docker containers..."
if pytest tests/test_build_container.py; then
    echo "Tests passed successfully!"
else
    handle_error "Some tests failed. Check logs for details."
fi

echo "Main setup completed successfully."
