import os
import docker
import logging
from tabulate import tabulate

# Get the current directory of the script
current_dir = os.path.dirname(os.path.abspath(__file__))

# Define the project root
project_root = os.path.dirname(current_dir)

# Define the log directory in the root of the project
log_directory = os.path.join(project_root, 'logs', 'docker_management_logs')

# Ensure the log directory exists, create it if it doesn't
os.makedirs(log_directory, exist_ok=True)

# Set up logging with the correct relative path for the log file
log_file = os.path.join(log_directory, 'build_all_containers.log')
logging.basicConfig(
    filename=log_file,
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

# Initialize Docker client
try:
    client = docker.from_env()
    docker_version = client.version()
    print(f"Docker client version: {docker_version['Version']}")
    logging.info(f"Docker client version: {docker_version['Version']}")
except Exception as e:
    logging.error(f"Failed to initialize Docker client: {e}")
    print(f"Error: Failed to initialize Docker client: {e}")
    exit(1)

# Function to check if a container already exists
def container_exists(container_name):
    try:
        client.containers.get(container_name)
        return True
    except docker.errors.NotFound:
        return False
    except docker.errors.APIError as api_error:
        logging.error(f"Docker API error while checking container '{container_name}': {api_error}")
        return False

# Get the base directory for the project
BASE_DIR = project_root
print(f"Base directory for project: {BASE_DIR}")
logging.info(f"Base directory for project: {BASE_DIR}")

# Prepare a list to store build results for tabulation
build_results = []

# Iterate over all subdirectories in the base directory
for dir_name in os.listdir(BASE_DIR):
    dir_path = os.path.join(BASE_DIR, dir_name)
    
    if os.path.isdir(dir_path):
        dockerfile_path = os.path.join(dir_path, 'Dockerfile')
        
        print(f"Checking directory: {dir_name}")
        logging.info(f"Checking directory: {dir_name}")
        print(f"Looking for Dockerfile at: {dockerfile_path}")
        logging.info(f"Looking for Dockerfile at: {dockerfile_path}")
        
        if os.path.isfile(dockerfile_path):
            image_name = f"devopscookbook-{dir_name.lower()}"
            container_name = f"{image_name}-container"
            
            print(f"Building Docker image: {image_name} from {dockerfile_path}...")
            logging.info(f"Building Docker image: {image_name} from {dockerfile_path}...")
            
            try:
                # Build the Docker image
                image, logs = client.images.build(
                    path=dir_path,
                    dockerfile=dockerfile_path,
                    tag=image_name,
                    rm=True
                )
                logging.info(f"Successfully built Docker image: {image_name}")
                
                # Capture build logs
                for chunk in logs:
                    if 'stream' in chunk:
                        log_message = chunk['stream'].strip()
                        if log_message:
                            logging.info(f"Build log for {image_name}: {log_message}")
                
                print(f"Successfully built Docker image: {image_name}")
                
                # Check if the container exists
                if container_exists(container_name):
                    print(f"Container '{container_name}' already exists. Starting the existing container...")
                    logging.info(f"Container '{container_name}' already exists. Starting the existing container...")
                    container = client.containers.get(container_name)
                    container.start()
                    logging.info(f"Started existing container: {container_name}")
                    print(f"Started existing container: {container_name}")
                else:
                    # Run the container
                    print(f"Running container for image: {image_name}...")
                    logging.info(f"Running container for image: {image_name}...")
                    container = client.containers.run(
                        image_name,
                        name=container_name,
                        detach=True,
                        tty=True,  # Allocate a pseudo-TTY
                        # Add other parameters as needed (ports, volumes, environment variables)
                    )
                    logging.info(f"Container started successfully for image: {image_name}")
                    print(f"Container started successfully for image: {image_name}")
                
                # Append successful build result
                build_results.append([image_name, "Built and Running"])
            
            except docker.errors.BuildError as build_error:
                error_message = f"Failed to build Docker image: {image_name}. Error: {build_error}"
                logging.error(error_message)
                print(f"Error: {error_message}")
                build_results.append([image_name, "Build Failed"])
            except docker.errors.APIError as api_error:
                error_message = f"Docker API error while building/running container '{container_name}': {api_error}"
                logging.error(error_message)
                print(f"Error: {error_message}")
                build_results.append([image_name, "API Error"])
            except Exception as e:
                error_message = f"Unexpected error while building/running container '{container_name}': {e}"
                logging.error(error_message)
                print(f"Error: {error_message}")
                build_results.append([image_name, "Unexpected Error"])
        else:
            print(f"No Dockerfile found in the '{dir_name}' directory.")
            logging.warning(f"No Dockerfile found in the '{dir_name}' directory.")
            build_results.append([dir_name, "No Dockerfile"])
    else:
        print(f"Skipping non-directory: {dir_name}")
        logging.info(f"Skipping non-directory: {dir_name}")

# Tabulate and log the build results
if build_results:
    table = tabulate(
        build_results,
        headers=["Image Name", "Build Status"],
        tablefmt="pretty"
    )
    print("\nDocker Build and Run Results:")
    print(table)
    logging.info("Docker Build and Run Results:\n" + table)
else:
    print("No Docker images were built.")
    logging.info("No Docker images were built.")

# List all running containers
print("\nListing all running Docker containers:")
logging.info("Listing all running Docker containers:")
running_containers = client.containers.list()
if running_containers:
    containers_table = []
    for container in running_containers:
        containers_table.append([container.name, container.id[:12], container.status])
    
    table = tabulate(
        containers_table,
        headers=["Container Name", "ID", "Status"],
        tablefmt="pretty"
    )
    print(table)
    logging.info("Running Docker Containers:\n" + table)
else:
    print("No Docker containers are currently running.")
    logging.info("No Docker containers are currently running.")
