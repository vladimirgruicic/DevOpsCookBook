import os
import docker
import pytest
import logging

# Set up the Docker client
client = docker.from_env()

# Hardcode the log file path in the root directory
log_file_path = os.path.join(os.getcwd(), 'test_containers.log')

# Ensure the log file is created in the root directory
if not os.path.exists(log_file_path):
    # Create an empty file if it does not exist
    open(log_file_path, 'w').close()

# Set up logging to both console and file (root directory)
logging.basicConfig(
    level=logging.DEBUG,  # Set to DEBUG to capture all log levels
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.StreamHandler(),  # Output to console
        logging.FileHandler(log_file_path)  # Output to file in root directory
    ]
)

# Function to handle error logs
def log_error(message):
    logging.error(message)
    print(message)  # Print to console as well

# Function to check if a container exists
def container_exists(container_name):
    try:
        client.containers.get(container_name)
        return True
    except docker.errors.NotFound:
        return False

# Function to check if an image exists
def image_exists(image_name):
    try:
        client.images.get(image_name)
        return True
    except docker.errors.ImageNotFound:
        return False

# Get the base directory for the project
BASE_DIR = os.getcwd()

# List of expected image names and container names
def get_expected_images_and_containers():
    images_and_containers = []
    for dir_name in os.listdir(BASE_DIR):
        dir_path = os.path.join(BASE_DIR, dir_name)
        if os.path.isdir(dir_path):
            dockerfile_path = os.path.join(dir_path, 'Dockerfile')
            if os.path.isfile(dockerfile_path):
                image_name = f"devopscookbook-{dir_name.lower()}"
                container_name = f"{image_name}-container"
                images_and_containers.append((image_name, container_name))
                logging.info(f"Found Dockerfile in: {dir_path}. Expected image: {image_name}, container: {container_name}")
    return images_and_containers

# Test if all images and containers are built and exist
def test_all_images_and_containers_exist():
    logging.info("Starting test: Checking if all images and containers exist...")
    
    # Get the list of expected images and containers
    expected_images_and_containers = get_expected_images_and_containers()

    # Assert if all expected images exist
    for image_name, container_name in expected_images_and_containers:
        logging.info(f"Checking if image exists: {image_name}")
        if not image_exists(image_name):
            log_error(f"Image {image_name} does not exist")
            pytest.fail(f"Image {image_name} does not exist")

    # Assert if all expected containers exist
    for image_name, container_name in expected_images_and_containers:
        logging.info(f"Checking if container exists: {container_name}")
        if not container_exists(container_name):
            log_error(f"Container {container_name} does not exist")
            pytest.fail(f"Container {container_name} does not exist")

    logging.info("All expected images and containers are present and running.")

# Run the test
if __name__ == "__main__":
    logging.debug("Starting the main function...")  # Debugging: Add a log to confirm script execution
    test_all_images_and_containers_exist()
    logging.info("Test completed.")

    # Ensuring all logs are flushed to the file
    logging.shutdown()  # Make sure all log records are flushed to file
