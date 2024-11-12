#!/bin/bash
# docker_cleanup.sh - Stops and removes all Docker containers.

# Function to handle errors
handle_error() {
    echo "Error: $1"
    exit 1
}

# Stop all running containers
echo "Stopping all running containers..."
running_containers=$(docker ps -q)
if [ -n "$running_containers" ]; then
    if ! docker stop $running_containers; then
        handle_error "Failed to stop containers."
    fi
    echo "All running containers have been stopped."
else
    echo "No running containers to stop."
fi

# Remove all containers
echo "Removing all containers..."
all_containers=$(docker ps -a -q)
if [ -n "$all_containers" ]; then
    if ! docker rm $all_containers; then
        handle_error "Failed to remove containers."
    fi
    echo "All containers have been removed."
else
    echo "No containers to remove."
fi

echo "Script completed successfully."
