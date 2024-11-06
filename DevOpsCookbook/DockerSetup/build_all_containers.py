import os
import docker

# Set up the Docker client
client = docker.from_env()

# Function to check if a container already exists
def container_exists(container_name):
    try:
        client.containers.get(container_name)
        return True
    except docker.errors.NotFound:
        return False

# Get the base directory for the project
BASE_DIR = os.getcwd()
print(f"Base directory for project: {BASE_DIR}")

# Iterate over all subdirectories in the base directory
for dir_name in os.listdir(BASE_DIR):
    dir_path = os.path.join(BASE_DIR, dir_name)
    
    if os.path.isdir(dir_path):
        dockerfile_path = os.path.join(dir_path, 'Dockerfile')
        
        print(f"Checking directory: {dir_name}")
        print(f"Looking for Dockerfile at: {dockerfile_path}")
        
        if os.path.isfile(dockerfile_path):
            image_name = f"devopscookbook-{dir_name.lower()}"
            print(f"Building Docker image: {image_name} from {dockerfile_path}...")

            # Build the Docker image
            try:
                image, logs = client.images.build(path=dir_path, dockerfile=dockerfile_path, tag=image_name)
                print(f"Successfully built Docker image: {image_name}")
                
                # Print build logs
                for log in logs:
                    print(log.get('stream', ''))

                # Define the container name
                container_name = f"{image_name}-container"
                
                # Check if the container exists
                if container_exists(container_name):
                    print(f"Container '{container_name}' already exists. Starting the existing container...")
                    container = client.containers.get(container_name)
                    container.start()
                    print(f"Started existing container: {container_name}")
                else:
                    # Run the container
                    print(f"Running container for image: {image_name}...")
                    container = client.containers.run(image_name, name=container_name, detach=True)
                    print(f"Container started successfully for image: {image_name}")
            except docker.errors.BuildError as build_error:
                print(f"Error: Failed to build Docker image: {image_name}. {build_error}")
            except Exception as e:
                print(f"Error: {e}")
        else:
            print(f"No Dockerfile found in the {dir_name} directory.")
        
# List all running containers
print("Listing all running Docker containers:")
for container in client.containers.list():
    print(f"{container.name}: {container.status}")
