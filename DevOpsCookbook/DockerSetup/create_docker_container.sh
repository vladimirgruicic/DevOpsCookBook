#!/bin/bash
# create_docker_container.sh - Creates Docker containers for all images listed in image_list.txt.

IMAGE_LIST_FILE="image_list.txt"

# Check if the image list file exists
if [ ! -f "$IMAGE_LIST_FILE" ]; then
  echo "Image list file not found!"
  exit 1
fi

# Loop through each image name in the image list
while IFS= read -r IMAGE_NAME; do
  echo "Pulling Docker image: $IMAGE_NAME..."
  docker pull $IMAGE_NAME
  
  echo "Creating and running container from image: $IMAGE_NAME..."
  docker run -d $IMAGE_NAME
  
  echo "Container created and running with image: $IMAGE_NAME."
done < "$IMAGE_LIST_FILE"
