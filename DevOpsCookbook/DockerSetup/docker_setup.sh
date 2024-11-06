#!/bin/bash
# docker_setup.sh - Main setup script for Docker, which installs, configures Docker, and creates containers.

# Function to handle errors
handle_error() {
    echo "Error: $1"
    exit 1
}

# Create a logs directory if it doesn’t exist
mkdir -p logs
BASE_DIR="$(pwd)/DockerSetup"

# Step 1: Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Executing: $BASE_DIR/install_docker.sh"
    # Execute the installation script and show output in terminal
    if "$BASE_DIR/install_docker.sh" | tee logs/install_docker.log; then
        echo "Docker installed successfully."
    else
        handle_error "Docker installation failed. Check logs/install_docker.log for details."
    fi
else
    echo "Docker is already installed. Skipping installation."
fi

# Step 2: Configure Docker
echo "Executing: $BASE_DIR/configure_docker.sh"
if "$BASE_DIR/configure_docker.sh" | tee logs/configure_docker.log; then
    echo "Docker configured successfully."
else
    handle_error "Docker configuration failed. Check logs/configure_docker.log for details."
fi

# Step 3: Create Docker containers using Python script
echo "Executing: $BASE_DIR/create_docker_container.py"
if python3 "$BASE_DIR/create_docker_container.py" | tee logs/create_docker_container.log; then
    echo "Docker containers created successfully."
else
    handle_error "Docker container creation failed. Check logs/create_docker_container.log for details."
fi

# Step 4: Build and run all containers for the project using Python
echo "Building all Docker containers for the project using Python script..."
echo "Executing: $BASE_DIR/build_all_containers.py"
if python3 "$BASE_DIR/build_all_containers.py" | tee logs/build_all_containers.log; then
    echo "All Docker containers built successfully."
else
    handle_error "Building all containers failed. Check logs/build_all_containers.log for details."
fi

# Step 5: Test the containers
echo "Testing the Docker containers..."
# Modify the path to point to the tests directory inside linux_fundamentals
TEST_DIR="$(pwd)/LinuxFundamentals/tests"

# Execute the test script(s) from the tests directory
echo "Executing: $TEST_DIR/test_containers.py"
if python3 "$TEST_DIR/test_containers.py" | tee logs/test_containers.log; then
    echo "Docker containers passed the tests successfully."
else
    handle_error "Docker containers testing failed. Check logs/test_containers.log for details."
fi

echo "Docker installation, configuration, container creation, and testing completed successfully."

