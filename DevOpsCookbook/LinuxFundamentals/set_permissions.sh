#!/bin/bash
# set_permissions.sh

# Create a new directory for development files
echo "Creating directory '/home/devuser/dev_files'..."
mkdir /home/devuser/dev_files

# Change the ownership of the directory to 'devuser'
echo "Changing ownership of '/home/devuser/dev_files' to 'devuser'..."
sudo chown devuser:devteam /home/devuser/dev_files

# Set permissions to allow read, write, and execute for the owner,
# and read and execute for group and others
echo "Setting permissions for '/home/devuser/dev_files'..."
sudo chmod 755 /home/devuser/dev_files

# Display message
echo "Directory '/home/devuser/dev_files' created with appropriate permissions."
