import os
import docker
import logging
from tabulate import tabulate

# Get the current directory of the script
current_dir = os.path.dirname(os.path.abspath(__file__))

# Define the log directory in the root of the project
log_directory = os.path.join(os.path.dirname(current_dir), 'logs', 'docker_management_logs')

# Ensure the directory exists, create it if it doesn't
if not os.path.exists(log_directory):
    os.makedirs(log_directory)

# Set up logging with the correct relative path for the log file
log_file = os.path.join(log_directory, 'check_scripts_folder.log')
logging.basicConfig(filename=log_file, level=logging.INFO)

# Initialize Docker client
client = docker.from_env()

def check_scripts_folder(container_name):
    """Checks if a 'scripts' folder exists and verifies the active script in the specified container."""
    try:
        logging.info(f"Attempting to get container: {container_name}")
        container = client.containers.get(container_name)
        logging.info(f"Successfully found container: {container_name}")
        
        # Check if the container is running
        if container.status != 'running':
            logging.warning(f"Container '{container_name}' is not running. It is in {container.status} state.")
            print(f"Container '{container_name}' is not running. It is in {container.status} state.")
            return

        # Step 1: List contents of the /scripts folder
        command = "ls /scripts"
        logging.info(f"Running command '{command}' in container {container_name}")
        result = container.exec_run(command)
        
        if result.exit_code == 0:
            folder_contents = result.output.decode().strip()
            logging.info(f"'scripts' folder contents in container '{container_name}':\n{folder_contents}")
            print(f"Contents of '/scripts' in '{container_name}':\n{folder_contents}")
        else:
            logging.warning(f"Failed to list '/scripts' folder in container '{container_name}'.")
            print(f"Failed to list '/scripts' folder in '{container_name}'.")

        # Step 2: Verify active script from Dockerfile's CMD or ENTRYPOINT
        logging.info(f"Inspecting active processes in container '{container_name}'...")
        process_command = "ps -aux"
        process_result = container.exec_run(process_command)
        
        if process_result.exit_code == 0:
            active_processes = process_result.output.decode().strip()
            logging.info(f"Active processes in '{container_name}':\n{active_processes}")
            print(f"Active processes in '{container_name}':\n{active_processes}")
        else:
            logging.warning(f"Could not retrieve active processes for '{container_name}'.")

    except docker.errors.NotFound:
        logging.error(f"Container '{container_name}' not found.")
        print(f"Error: Container '{container_name}' not found.")
    except docker.errors.APIError as api_error:
        logging.error(f"Docker API error occurred: {api_error}")
        print(f"Error: Docker API error occurred: {api_error}")
    except Exception as e:
        logging.error(f"An unexpected error occurred: {e}")
        print(f"An unexpected error occurred: {e}")

def main():
    # List all running containers
    containers = client.containers.list()
    if not containers:
        print("No running containers found.")
        logging.info("No running containers found.")
        return

    # Check each running container
    for container in containers:
        print(f"\n--- Checking container '{container.name}' ---")
        check_scripts_folder(container.name)

if __name__ == "__main__":
    main()
