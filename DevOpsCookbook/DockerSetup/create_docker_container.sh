#!/bin/bash
# create_docker_container.sh - Creates Docker containers for all images listed in image_list.txt.

# Base directory for the scripts
BASE_DIR="$(pwd)"

# Path to the image list file
IMAGE_LIST_FILE="$BASE_DIR/DockerSetup/image_list.txt"

# Path to the keep_alive script
KEEP_ALIVE_SCRIPT="$BASE_DIR/DockerSetup/keep_alive.sh"

# Debugging: Print the paths being checked
echo "Checking for image list file at: $IMAGE_LIST_FILE"
echo "Checking for keep alive script at: $KEEP_ALIVE_SCRIPT"

# Check if the image list file exists
if [ ! -f "$IMAGE_LIST_FILE" ]; then
  echo "Image list file not found at $IMAGE_LIST_FILE!"
  exit 1
fi

# Check if the keep_alive script exists
if [ ! -f "$KEEP_ALIVE_SCRIPT" ]; then
  echo "Keep alive script not found at $KEEP_ALIVE_SCRIPT!"
  exit 1
fi

# Debugging: Check if the image list file is empty
if [ ! -s "$IMAGE_LIST_FILE" ]; then
  echo "Image list file is empty at $IMAGE_LIST_FILE!"
  exit 1
fi

# Print the contents of the image list file for debugging
echo "Contents of image_list.txt:"
cat "$IMAGE_LIST_FILE"

# Loop through each image name in the image list
while IFS= read -r IMAGE_NAME; do
  # Trim whitespace from the image name
  IMAGE_NAME=$(echo "$IMAGE_NAME" | xargs)

  # Check if the image name is empty
  if [ -z "$IMAGE_NAME" ]; then
    echo "Skipping empty line."
    continue
  fi

  # Check if the image already exists in Docker
  if docker images --format '{{.Repository}}:{{.Tag}}' | grep -q "^$IMAGE_NAME$"; then
    echo "Image '$IMAGE_NAME' already exists in Docker. Skipping."
    continue
  fi

  # Check if the image is listed in image_list.txt
  if ! grep -q "^$IMAGE_NAME$" "$IMAGE_LIST_FILE"; then
    echo "Image '$IMAGE_NAME' is not listed in $IMAGE_LIST_FILE. Skipping."
    continue
  fi

  echo "Pulling Docker image: $IMAGE_NAME..."
  docker pull "$IMAGE_NAME"
  
  echo "Creating and running container from image: $IMAGE_NAME..."

  # Run the container and ensure keep_alive.sh runs and keeps the container alive
  CONTAINER_ID=$(docker run -d "$IMAGE_NAME" /bin/sh -c "/keep_alive.sh; tail -f /dev/null")
  
  echo "Container created and running with image: $IMAGE_NAME. Container ID: $CONTAINER_ID."

  # Wait a few seconds to allow the keep_alive script to start
  sleep 5
  
  # Check if the keep_alive_status.txt file exists in the container
  if docker exec "$CONTAINER_ID" test -f /tmp/keep_alive_status.txt; then
    echo "Keep alive script is running inside the container."
  else
    echo "Keep alive script did not run inside the container."
  fi
done < "$IMAGE_LIST_FILE"

# List all running containers
echo "Listing all running Docker containers:"
docker ps

echo "All containers have been created successfully."
