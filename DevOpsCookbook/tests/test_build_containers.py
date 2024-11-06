import os
import subprocess
import time
import pytest
import docker

# Set up the Docker client
client = docker.from_env()

# Function to check if a container exists and is running
def container_is_running(container_name):
    try:
        container = client.containers.get(container_name)
        return container.status == 'running'
    except docker.errors.NotFound:
        return False

# Get the base directory for the project
BASE_DIR = os.getcwd()

# List of expected container names based on your directory names
def get_expected_containers():
    containers = []
    for dir_name in os.listdir(BASE_DIR):
        dir_path = os.path.join(BASE_DIR, dir_name)
        if os.path.isdir(dir_path):
            dockerfile_path = os.path.join(dir_path, 'Dockerfile')
            if os.path.isfile(dockerfile_path):
                image_name = f"devopscookbook-{dir_name.lower()}"
                container_name = f"{image_name}-container"
                containers.append(container_name)
    return containers

# Test if all containers are built and running
def test_all_containers_running():
    # Get the list of expected containers
    expected_containers = get_expected_containers()

    # Run the build script to build and start containers
    build_command = ['bash', 'DockerSetup/build_all_containers.sh']
    process = subprocess.Popen(build_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = process.communicate()

    # Allow some time for containers to start up
    time.sleep(5)

    # Check if all expected containers are running
    for container_name in expected_containers:
        assert container_is_running(container_name), f"Container {container_name} is not running"

    print("All containers are running as expected.")

# Optionally, you can add a function to test specific functionality within the containers (if necessary)

