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
log_file = os.path.join(log_directory, 'list_images.log')
logging.basicConfig(filename=log_file, level=logging.INFO)

# Initialize Docker client
client = docker.from_env()

# List all images
images = client.images.list()

# Prepare a list to store image data for tabulation
image_data = []

# Process images
if not images:
    logging.info("No Docker images found.")
else:
    for image in images:
        # Get image tags and size
        tags = image.tags if image.tags else ['<none>']
        size = image.attrs['Size']
        
        # Filter out empty tags (images with no tags, i.e., <none>)
        if tags != ['<none>']:
            image_data.append([tags[0], size])

    # If there are images, log the formatted table
    if image_data:
        logging.info("Docker Images found:")
        table = tabulate(image_data, headers=["Image Name", "Size (bytes)"], tablefmt="pretty")
        logging.info(table)

        # Optionally, print it as well
        print(table)
    else:
        logging.info("No valid Docker images to display.")

