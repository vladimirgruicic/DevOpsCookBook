#!/bin/bash
# create_docker_container.sh - Creates a Docker container with a given image.

if [ -z "$1" ]; then
  echo "Usage: $0 <image_name>"
  exit 1
fi

IMAGE_NAME=$1
echo "Pulling Docker image: $IMAGE_NAME..."
docker pull $IMAGE_NAME

echo "Creating and running container from image: $IMAGE_NAME..."
docker run -d $IMAGE_NAME

echo "Container created and running with image: $IMAGE_NAME."
