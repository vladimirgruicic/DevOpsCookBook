import os
import docker
import logging
from tabulate import tabulate

# Get the current directory of the script
current_dir = os.path.dirname(os.path.abspath(__file__))

# Print the current directory (pwd)
print(f"Current directory: {current_dir}")

# Define the log directory in the root of the project (instead of DockerManagement)
log_directory = os.path.join(os.path.dirname(current_dir), 'logs', 'docker_management_logs')

# Print the log directory where logs will be stored
print(f"Logs will be stored in: {log_directory}")

# Ensure the directory exists, create it if it doesn't
if not os.path.exists(log_directory):
    os.makedirs(log_directory)

# Set up logging with the correct relative path for the log file
log_file = os.path.join(log_directory, 'check_scripts_folder.log')
logging.basicConfig(filename=log_file, level=logging.INFO)

# Initialize Docker client
client = docker.from_env()

def check_scripts_folder(container_name):
    """Checks if a 'scripts' folder exists in the specified container."""
    try:
        # Log the attempt to get the container
        logging.info(f"Attempting to get container: {container_name}")
        
        # Get the container by name
        container = client.containers.get(container_name)
        logging.info(f"Successfully found container: {container_name}")
        
        # Check if the container is running
        if container.status != 'running':
            logging.warning(f"Container '{container_name}' is not running. It is in {container.status} state.")
            print(f"Container '{container_name}' is not running. It is in {container.status} state.")
            return

        logging.info(f"Container '{container_name}' is running. Proceeding to check the '/scripts' folder.")
        
        # Run a command to list the contents of the /scripts directory
        command = "ls /scripts"
        logging.info(f"Running command: {command} in container {container_name}")
        
        result = container.exec_run(command)
        
        # Log the command result
        logging.info(f"Command executed with exit code {result.exit_code}")
        if result.exit_code == 0:
            logging.info(f"'scripts' folder contents in container '{container_name}':")
            folder_contents = result.output.decode()
            logging.debug(folder_contents)  # Log the contents of the folder
            print(folder_contents)
        else:
            logging.warning(f"'scripts' folder not found or is empty in container '{container_name}'.")
            print(f"'scripts' folder not found or is empty in container '{container_name}'.")

    except docker.errors.NotFound:
        logging.error(f"Container '{container_name}' not found.")
        print(f"Error: Container '{container_name}' not found.")
    except docker.errors.APIError as api_error:
        logging.error(f"Docker API error occurred: {api_error}")
        print(f"Error: Docker API error occurred: {api_error}")
    except Exception as e:
        logging.error(f"An unexpected error occurred: {e}")
        print(f"An unexpected error occurred: {e}")
