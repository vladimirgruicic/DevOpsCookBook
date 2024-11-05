#!/bin/bash
# stop_and_remove_all_containers.sh - Stops and removes all Docker containers.

# Function to handle errors
handle_error() {
    echo "Error: $1"
    exit 1
}

# Stop all running containers
echo "Stopping all running containers..."
if ! docker stop $(docker ps -q); then
    handle_error "Failed to stop containers."
fi
echo "All running containers have been stopped."

# Remove all containers
echo "Removing all containers..."
if ! docker rm $(docker ps -a -q); then
    handle_error "Failed to remove containers."
fi
echo "All containers have been removed."

echo "Script completed successfully."
