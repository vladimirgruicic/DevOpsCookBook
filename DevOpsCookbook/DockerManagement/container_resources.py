import os
import docker
import logging
from tabulate import tabulate

# Get the current directory of the script
current_dir = os.path.dirname(os.path.abspath(__file__))

# Define the log directory in the root of the project (instead of DockerManagement)
log_directory = os.path.join(os.path.dirname(current_dir), 'logs', 'docker_management_logs')

# Ensure the directory exists, create it if it doesn't
if not os.path.exists(log_directory):
    os.makedirs(log_directory)

# Set up logging with the correct relative path for the log file
log_file = os.path.join(log_directory, 'list_containers.log')
logging.basicConfig(filename=log_file, level=logging.INFO)

# Initialize Docker client
client = docker.from_env()

def list_container_resources():
    """Lists running containers with their CPU and memory usage limits (if set)."""
    containers = client.containers.list()

    # Prepare a list to store container data for tabulation
    data = []

    if not containers:
        logging.info("No running containers found.")
        print("No running containers found.")
    else:
        for container in containers:
            container_info = container.attrs
            cpu_limit = container_info.get('HostConfig', {}).get('NanoCpus', 0) / 1e9  # Convert from nano CPUs
            memory_limit = container_info.get('HostConfig', {}).get('Memory', 0) / (1024 ** 2)  # MB

            # Prepare the row for tabulation
            data.append([
                container.name,
                container.image.tags[0] if container.image.tags else "<untagged>",
                f"{cpu_limit} CPUs" if cpu_limit else "Unlimited",
                f"{memory_limit} MB" if memory_limit else "Unlimited"
            ])

        # If there are containers, log the formatted table
        if data:
            logging.info("Running containers with CPU and memory limits:")
            table = tabulate(data, headers=["Container Name", "Image", "CPU Limit", "Memory Limit"], tablefmt="pretty")
            logging.info(table)

            # Optionally, print the table
            print(table)
        else:
            logging.info("No valid containers to display.")

    return data

# Call the function to test the output
list_container_resources()
