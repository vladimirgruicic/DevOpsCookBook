#!/bin/bash
# create_docker_container.sh - Pulls and runs Docker containers from images listed in image_list.txt.

# Base directory for the script
BASE_DIR="$(pwd)"
IMAGE_LIST_FILE="$BASE_DIR/DockerSetup/image_list.txt"

# Check if the image list file exists
if [ ! -f "$IMAGE_LIST_FILE" ]; then
  echo "Error: Image list file not found at $IMAGE_LIST_FILE!"
  exit 1
fi

# Flag to check if containers were created
CONTAINER_CREATED=false
FAILED_IMAGES=()

# Function to check if a Docker image exists locally
function image_exists {
  docker images --format '{{.Repository}}:{{.Tag}}' | grep -q "^$1$"
}

# Function to check if a Docker container already exists
function container_exists {
  docker ps -a --format '{{.Names}}' | grep -q "^$1$"
}

# Loop through each image in the list
while IFS= read -r IMAGE_NAME || [ -n "$IMAGE_NAME" ]; do
  IMAGE_NAME=$(echo "$IMAGE_NAME" | tr -d '\r' | xargs)
  if [ -z "$IMAGE_NAME" ]; then
    echo "Skipping empty line."
    continue
  fi

  # Check if the image already exists locally
  if image_exists "$IMAGE_NAME"; then
    echo "Image '$IMAGE_NAME' already exists locally. Skipping pull."
  else
    echo "Pulling Docker image: $IMAGE_NAME..."
    if ! docker pull "$IMAGE_NAME"; then
      echo "Failed to pull Docker image: $IMAGE_NAME"
      FAILED_IMAGES+=("$IMAGE_NAME")
      continue
    fi
  fi

  # Define container name
  CONTAINER_NAME="${IMAGE_NAME//[:\/]/-}-container"

  # Check if the container already exists
  if container_exists "$CONTAINER_NAME"; then
    echo "Container '$CONTAINER_NAME' already exists. Starting the existing container..."
    if ! docker start "$CONTAINER_NAME"; then
      echo "Failed to start existing container: $CONTAINER_NAME"
      FAILED_IMAGES+=("$IMAGE_NAME")
      continue
    fi
    echo "Started existing container: $CONTAINER_NAME."
    continue
  fi

  echo "Running container from image: $IMAGE_NAME..."
  
  # Start container with a command to keep it alive, and set restart policy
  if ! docker run -d --restart unless-stopped --name "$CONTAINER_NAME" "$IMAGE_NAME" tail -f /dev/null; then
    echo "Failed to run container from image: $IMAGE_NAME"
    FAILED_IMAGES+=("$IMAGE_NAME")
    continue
  fi
  
  echo "Container created and running for image: $IMAGE_NAME."
  CONTAINER_CREATED=true
done < "$IMAGE_LIST_FILE"

# List all running containers
echo "Listing all running Docker containers:"
docker ps

# Cleanup or report failed images
if [ ${#FAILED_IMAGES[@]} -gt 0 ]; then
  echo "Some images failed to pull or run:"
  printf '%s\n' "${FAILED_IMAGES[@]}"
fi

echo "Docker setup completed."
