#!/bin/bash
# main_setup.sh - Main script to start the overall setup.

# Function to handle errors
handle_error() {
    echo "Error: $1"
    echo "Current directory: $(pwd)"
    exit 1
}

# Create a logs directory if it doesn't exist
mkdir -p logs

# Step 1: Check if Python is installed
echo "Checking if Python is installed..."
if ! command -v python3 &> /dev/null; then
    echo "Python is not installed. Installing Python..."
    if ! sudo apt-get update || ! sudo apt-get install -y python3 python3-pip | tee -a logs/python_install.log; then
        handle_error "Failed to install Python. Check logs/python_install.log for details."
    fi
    echo "Python installed successfully."
else
    echo "Python is already installed."
fi

# Step 2: Install pip (if it's not installed)
echo "Checking if pip is installed..."
if ! command -v pip3 &> /dev/null; then
    echo "pip is not installed. Installing pip..."
    if ! sudo apt-get install -y python3-pip | tee -a logs/pip_install.log; then
        handle_error "Failed to install pip. Check logs/pip_install.log for details."
    fi
    echo "pip installed successfully."
else
    echo "pip is already installed."
fi

# Step 3: Install pytest and docker SDK directly with pip
echo "Installing pytest and docker SDK with pip..."
pip3 install pytest docker tabulate| tee -a logs/pip_packages_install.log || handle_error "Failed to install pytest or docker SDK. Check logs/pip_packages_install.log for details."

# Step 4: List installed packages
echo "Listing installed packages..."
pip3 list | tee -a logs/pip_packages_list.log || handle_error "Failed to list installed packages. Check logs/pip_packages_list.log for details."

# Step 5: Make the scripts executable
echo "Making all scripts executable..."
chmod +x make_scripts_executable.sh | tee -a logs/make_scripts_executable.log || handle_error "Failed to change permissions for make_scripts_executable.sh. Check logs/make_scripts_executable.log for details."

# Run the script to make other scripts executable
if [[ -f make_scripts_executable.sh ]]; then
    echo "Executing: ./make_scripts_executable.sh"
    ./make_scripts_executable.sh | tee -a logs/make_scripts_execution.log || handle_error "Failed to run make_scripts_executable.sh. Check logs/make_scripts_execution.log for details."
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
./DockerSetup/docker_setup.sh | tee -a logs/docker_setup.log || handle_error "Docker setup failed. Check logs/docker_setup.log for details."

# Step 8: Generate the directory structure and store it in directory_structure.txt
echo "Generating directory structure and saving it to directory_structure.txt..."
tree -a -I 'node_modules|.git|.idea|*.log' -L 10 . > directory_structure.txt || handle_error "Failed to generate directory structure. Check logs/directory_structure.log for details."

# Step 9: Run the tests to ensure everything is working correctly
echo "Running tests to verify Docker containers..."

# Set the log file for the tests
TEST_LOG="logs/test_results.log"

# Run pytest with verbose output and show logs in the console
ROOT_DIR=$(pwd)
if pytest  "$ROOT_DIR/tests/test_build_containers.py" | tee -a "$TEST_LOG"; then
    echo "Tests passed successfully."
else
    handle_error "Some tests failed. Check $TEST_LOG for details."
fi

echo "Main setup completed successfully."
