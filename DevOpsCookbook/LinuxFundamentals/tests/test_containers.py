import os
import pytest
import docker

# Set up the Docker client
client = docker.from_env()

# Function to check if an image exists
def image_exists(image_name):
    try:
        client.images.get(image_name)
        return True
    except docker.errors.ImageNotFound:
        return False

# Function to check if a container exists and is running
def container_exists_and_running(container_name):
    try:
        container = client.containers.get(container_name)
        if container.status == "running":
            return True
        return False
    except docker.errors.NotFound:
        return False

# Directory to check for images and containers
BASE_DIR = os.getcwd()

# Test cases
@pytest.mark.parametrize("dir_name", [d for d in os.listdir(BASE_DIR) if os.path.isdir(os.path.join(BASE_DIR, d))])
def test_container_build_and_run(dir_name):
    # Image and container name based on the directory name
    image_name = f"devopscookbook-{dir_name.lower()}"
    container_name = f"{image_name}-container"
    
    # Check if the image was built
    assert image_exists(image_name), f"Image {image_name} does not exist."
    
    # Check if the container exists and is running
    assert container_exists_and_running(container_name), f"Container {container_name} is not running or doesn't exist."

    print(f"Test passed for image: {image_name} and container: {container_name}")

