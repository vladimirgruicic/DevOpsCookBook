#!/bin/bash
# docker_setup.sh - Main setup script for Docker, which installs, configures Docker, creates network, and creates containers.

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

# **Step 3: Create Docker network**
create_docker_network() {
    echo "Creating a custom Docker network..."
    
    # Set NETWORK_NAME to the name of the root directory
    NETWORK_NAME=$(basename "$(pwd)")


    # Check if the network already exists
    if docker network ls --format '{{.Name}}' | grep -w "$NETWORK_NAME" > /dev/null 2>&1; then
        echo "Network '$NETWORK_NAME' already exists. Skipping creation."
    else
        if docker network create --driver bridge "$NETWORK_NAME" | tee logs/create_network.log; then
            echo "Docker network '$NETWORK_NAME' created successfully."
        else
            handle_error "Failed to create Docker network. Check logs/create_network.log for details."
        fi
    fi
}

# Call the network creation function
create_docker_network

# Step 4: Build and run all containers for the project using Python
echo "Building all Docker containers for the project using Python script..."
echo "Executing: $BASE_DIR/build_all_containers.py"
if python3 "$BASE_DIR/build_all_containers.py" --network "$NETWORK_NAME" | tee logs/build_all_containers.log; then
    echo "All Docker containers built successfully."
else
    handle_error "Building all containers failed. Check logs/build_all_containers.log for details."
fi

echo "Docker installation, configuration, network creation, and container creation completed successfully."
