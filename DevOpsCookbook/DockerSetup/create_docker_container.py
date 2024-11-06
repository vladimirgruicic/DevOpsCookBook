import os
import docker
import sys

# Path to the image list file
BASE_DIR = os.getcwd()
IMAGE_LIST_FILE = os.path.join(BASE_DIR, "DockerSetup", "image_list.txt")
LOGS_DIR = os.path.join(BASE_DIR, "logs")

# Create logs directory if it doesn't exist
os.makedirs(LOGS_DIR, exist_ok=True)

# Initialize Docker client
client = docker.from_env()

# Function to handle errors
def handle_error(message):
    print(f"Error: {message}")
    sys.exit(1)

# Function to check if a Docker image exists locally
def image_exists(image_name):
    try:
        client.images.get(image_name)  # Try to get the image by name
        return True
    except docker.errors.ImageNotFound:
        return False

# Function to check if a Docker container already exists
def container_exists(container_name):
    try:
        client.containers.get(container_name)  # Try to get the container by name
        return True
    except docker.errors.NotFound:
        return False

# Function to pull Docker image
def pull_image(image_name):
    print(f"Pulling Docker image: {image_name}...")
    try:
        client.images.pull(image_name)  # Pull the Docker image
        return True
    except docker.errors.APIError as e:
        print(f"Failed to pull Docker image: {image_name}, {str(e)}")
        return False

# Function to run Docker container
def run_container(image_name):
    container_name = image_name.replace(":", "-").replace("/", "-") + "-container"
    
    # Check if container exists
    if container_exists(container_name):
        print(f"Container '{container_name}' already exists. Starting it...")
        container = client.containers.get(container_name)
        container.start()
        print(f"Started existing container: {container_name}.")
        return True

    # Create and run the container if not already running
    print(f"Running container from image: {image_name}...")
    try:
        container = client.containers.run(
            image_name,
            name=container_name,
            detach=True,
            restart_policy={"Name": "unless-stopped"},
            command="tail -f /dev/null"  # Keep the container running
        )
        print(f"Container created and running for image: {image_name}.")
        return True
    except docker.errors.APIError as e:
        print(f"Failed to run container from image: {image_name}, {str(e)}")
        return False

# Function to read image list and process containers
def create_containers_from_image_list():
    if not os.path.exists(IMAGE_LIST_FILE):
        handle_error(f"Image list file not found at {IMAGE_LIST_FILE}!")

    failed_images = []
    container_created = False
    
    with open(IMAGE_LIST_FILE, 'r') as file:
        for line in file:
            image_name = line.strip()
            if not image_name:
                print("Skipping empty line.")
                continue

            # Check if image exists locally, otherwise pull it
            if image_exists(image_name):
                print(f"Image '{image_name}' already exists locally. Skipping pull.")
            else:
                if not pull_image(image_name):
                    failed_images.append(image_name)
                    continue

            # Run the container from the image
            if not run_container(image_name):
                failed_images.append(image_name)
                continue
            
            container_created = True
    
    # List all running containers
    print("Listing all running Docker containers:")
    for container in client.containers.list():
        print(f"- {container.name}")

    # Report any failed images
    if failed_images:
        print("Some images failed to pull or run:")
        for image in failed_images:
            print(image)

    if container_created:
        print("Docker setup completed.")
    else:
        print("No containers were created.")

if __name__ == "__main__":
    create_containers_from_image_list()