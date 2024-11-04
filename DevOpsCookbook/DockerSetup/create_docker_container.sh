#!/bin/bash
# create_docker_container.sh - Creates Docker containers for all images listed in image_list.txt.

# Base directory for the scripts
BASE_DIR="$(pwd)"

# Path to the image list file
IMAGE_LIST_FILE="$BASE_DIR/DockerSetup/image_list.txt"

# Check if the image list file exists
if [ ! -f "$IMAGE_LIST_FILE" ]; then
  echo "Error: Image list file not found at $IMAGE_LIST_FILE!"
  exit 1
fi

# Initialize a variable to track if any containers were created
CONTAINER_CREATED=false

# Loop through each image name in the image list
while IFS= read -r IMAGE_NAME || [ -n "$IMAGE_NAME" ]; do
  # Remove any trailing whitespace or carriage return characters
  IMAGE_NAME=$(echo "$IMAGE_NAME" | tr -d '\r' | xargs)

  # Skip empty lines
  if [ -z "$IMAGE_NAME" ]; then
    echo "Warning: Skipping empty line in image list."
    continue
  fi

  echo "Pulling Docker image: $IMAGE_NAME..."
  
  # Pull the Docker image and check for errors
  if ! docker pull "$IMAGE_NAME"; then
    echo "Error: Failed to pull Docker image: $IMAGE_NAME"
    continue
  fi
  
  echo "Creating and running container from image: $IMAGE_NAME..."
  
  # Create and run the Docker container
  if ! docker run -d "$IMAGE_NAME"; then
    echo "Error: Failed to create and run container from image: $IMAGE_NAME"
    continue
  fi
  
  echo "Container created and running with image: $IMAGE_NAME."
  CONTAINER_CREATED=true
done < "$IMAGE_LIST_FILE"

# List all running containers
echo "Listing all running Docker containers:"
if [ "$CONTAINER_CREATED" = true ]; then
  docker ps
else
  echo "No containers were created."
fi

echo "Docker setup completed successfully."
