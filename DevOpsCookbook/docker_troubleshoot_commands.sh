#!/bin/bash
# docker_troubleshoot_commands.sh - Collection of Docker troubleshooting commands with explanations.

# This script provides a set of Docker commands to help troubleshoot containers.
# You can uncomment the commands you wish to execute and run the script.
# Replace placeholders like CONTAINER_ID_OR_NAME with actual values before running.

# List all Docker containers (running and stopped)
echo "Listing all containers (running and stopped):"
docker ps -a

echo "--------------------------------------------"

# List all running Docker containers
echo "Listing all running containers:"
docker ps

echo "--------------------------------------------"

# View real-time stats for all running containers
echo "Showing real-time stats for all running containers:"
docker stats --no-stream

echo "--------------------------------------------"

# List Docker images
echo "Listing all Docker images:"
docker images

echo "--------------------------------------------"

# Display Docker system-wide information
echo "Displaying Docker system-wide information:"
docker info

echo "--------------------------------------------"

# Remove all stopped containers
# Uncomment the following lines to remove all stopped containers
# echo "Removing all stopped containers:"
# docker container prune -f

# echo "--------------------------------------------"

# Remove dangling images
# Uncomment the following lines to remove dangling images
# echo "Removing dangling images:"
# docker image prune -f

# echo "--------------------------------------------"

# Remove unused data (containers, networks, images, and build cache)
# **WARNING: This will remove a lot of data. Use with caution.**
# Uncomment the following lines to perform system prune
# echo "Removing unused data:"
# docker system prune -a -f

# echo "--------------------------------------------"

# Inspect a container
# Replace CONTAINER_ID_OR_NAME with the actual container ID or name
# Uncomment the following lines to inspect a container
# CONTAINER_ID_OR_NAME="your_container_id_or_name"
# echo "Inspecting container $CONTAINER_ID_OR_NAME:"
# docker inspect "$CONTAINER_ID_OR_NAME"

# echo "--------------------------------------------"

# View logs of a container
# Replace CONTAINER_ID_OR_NAME with the actual container ID or name
# Uncomment the following lines to view logs
# CONTAINER_ID_OR_NAME="your_container_id_or_name"
# echo "Viewing logs for container $CONTAINER_ID_OR_NAME:"
# docker logs "$CONTAINER_ID_OR_NAME"

# echo "--------------------------------------------"

# Execute into a running container's shell
# Replace CONTAINER_ID_OR_NAME with the actual container ID or name
# Uncomment the following lines to exec into a container
# CONTAINER_ID_OR_NAME="your_container_id_or_name"
# echo "Executing into container $CONTAINER_ID_OR_NAME:"
# if ! docker exec -it "$CONTAINER_ID_OR_NAME" /bin/bash 2>/dev/null; then
#     docker exec -it "$CONTAINER_ID_OR_NAME" /bin/sh
# fi

# echo "--------------------------------------------"

# Start a stopped container
# Replace CONTAINER_ID_OR_NAME with the actual container ID or name
# Uncomment the following lines to start a container
# CONTAINER_ID_OR_NAME="your_container_id_or_name"
# echo "Starting container $CONTAINER_ID_OR_NAME:"
# docker start "$CONTAINER_ID_OR_NAME"

# echo "--------------------------------------------"

# Stop a running container
# Replace CONTAINER_ID_OR_NAME with the actual container ID or name
# Uncomment the following lines to stop a container
# CONTAINER_ID_OR_NAME="your_container_id_or_name"
# echo "Stopping container $CONTAINER_ID_OR_NAME:"
# docker stop "$CONTAINER_ID_OR_NAME"

# echo "--------------------------------------------"

# Remove a specific container
# Replace CONTAINER_ID_OR_NAME with the actual container ID or name
# **WARNING: This will delete the container. Data inside will be lost if not persisted.**
# Uncomment the following lines to remove a container
# CONTAINER_ID_OR_NAME="your_container_id_or_name"
# echo "Removing container $CONTAINER_ID_OR_NAME:"
# docker rm "$CONTAINER_ID_OR_NAME"

# echo "--------------------------------------------"

# Remove a specific image
# Replace IMAGE_ID_OR_NAME with the actual image ID or name
# **WARNING: This will delete the image from your system.**
# Uncomment the following lines to remove an image
# IMAGE_ID_OR_NAME="your_image_id_or_name"
# echo "Removing image $IMAGE_ID_OR_NAME:"
# docker rmi "$IMAGE_ID_OR_NAME"

# echo "--------------------------------------------"

# Check Docker daemon status
echo "Checking if Docker daemon is running:"
if ! pgrep -x "dockerd" > /dev/null; then
    echo "Docker daemon is not running."
else
    echo "Docker daemon is running."
fi

echo "--------------------------------------------"

# View network configurations
echo "Listing all Docker networks:"
docker network ls

echo "--------------------------------------------"

# Inspect a Docker network
# Replace NETWORK_ID_OR_NAME with the actual network ID or name
# Uncomment the following lines to inspect a network
# NETWORK_ID_OR_NAME="your_network_id_or_name"
# echo "Inspecting network $NETWORK_ID_OR_NAME:"
# docker network inspect "$NETWORK_ID_OR_NAME"

# echo "--------------------------------------------"

# Display disk usage for Docker objects
echo "Displaying disk usage for Docker objects:"
docker system df

echo "--------------------------------------------"

echo "Docker troubleshooting commands execution completed."
