#!/bin/bash
# build_all_containers.sh - Builds Docker containers for each main directory in the DevOpsCookbook project.

# Set the base directory for the project
BASE_DIR="$(pwd)"
echo "Base directory for project: $BASE_DIR"  # Added for clarity

# Function to check if a Docker container already exists
function container_exists {
  docker ps -a --format '{{.Names}}' | grep -q "^$1$"
}

# Iterate over all subdirectories in the base directory
for dir in "$BASE_DIR"/*; do
  if [[ -d "$dir" ]]; then
    # Check if a Dockerfile exists in the current directory
    DOCKERFILE_PATH="$dir/Dockerfile"
    DIR_NAME="$(basename "$dir")"
    
    echo "Checking directory: $DIR_NAME"  # Debugging line
    echo "Looking for Dockerfile at: $DOCKERFILE_PATH"  # Debugging line

    if [[ -f "$DOCKERFILE_PATH" ]]; then
      # Extract the directory name as the image name
      IMAGE_NAME="devopscookbook-$(echo "$DIR_NAME" | tr '[:upper:]' '[:lower:]')"
      
      echo "Building Docker image: $IMAGE_NAME from $DOCKERFILE_PATH..."
      echo "Current working directory: $(pwd)"  # Display current directory

      # Build the Docker image
      if docker build -t "$IMAGE_NAME" -f "$DOCKERFILE_PATH" "$dir"; then
        echo "Successfully built Docker image: $IMAGE_NAME."
        
        # Inform about the Dockerfile location dynamically
        echo "Dockerfile is located in the $DIR_NAME folder."
        
        # Define the container name
        CONTAINER_NAME="${IMAGE_NAME}-container"
        
        # Check if the container already exists
        if container_exists "$CONTAINER_NAME"; then
          echo "Container '$CONTAINER_NAME' already exists. Starting the existing container..."
          if docker start "$CONTAINER_NAME"; then
            echo "Started existing container: $CONTAINER_NAME."
          else
            echo "Error: Failed to start existing container: $CONTAINER_NAME."
          fi
        else
          # Run the container
          echo "Running container for image: $IMAGE_NAME..."
          if docker run -d --name "$CONTAINER_NAME" "$IMAGE_NAME"; then
            echo "Container started successfully for image: $IMAGE_NAME."
          else
            echo "Error: Failed to start container for image: $IMAGE_NAME."
          fi
        fi
      else
        echo "Error: Failed to build Docker image: $IMAGE_NAME."
      fi
    else
      echo "No Dockerfile found in the $DIR_NAME directory."
    fi
  fi
done

# List all running containers
echo "Listing all running Docker containers:"
docker ps
