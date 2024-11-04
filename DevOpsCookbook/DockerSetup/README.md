# Docker Setup

This directory contains scripts to install and configure Docker on various environments, as well as commands to create and manage Docker containers.

## Contents

1. **install_docker.sh**
   - Installs Docker on the system (supports Ubuntu and other Linux distributions).
   - Usage: `bash install_docker.sh`

2. **configure_docker.sh**
   - Configures Docker settings such as user permissions.
   - Usage: `bash configure_docker.sh`

3. **create_docker_container.sh**
   - Creates a Docker container with a specified image.
   - Usage: `bash create_docker_container.sh <image_name>`

4. **docker_cleanup.sh**
   - Removes stopped containers and unused images to free up space.
   - Usage: `bash docker_cleanup.sh`

## How to Use the Scripts

1. **Run Docker Installation**:  
   ```bash
   sudo bash install_docker.sh
