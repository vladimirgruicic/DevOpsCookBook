#!/bin/bash
# docker_cleanup.sh - Cleans up Docker containers and images.

echo "Removing stopped containers..."
docker container prune -f

echo "Removing unused images..."
docker image prune -a -f

echo "Docker cleanup complete!"
