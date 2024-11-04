#!/bin/bash
# user_and_group_management.sh

# Create a new user named 'newuser'
echo "Creating user 'newuser'..."
sudo useradd -m newuser
echo "User 'newuser' created."

# Set a password for the new user
echo "Setting password for 'newuser'..."
echo "newuser:password" | sudo chpasswd

# Modify the user to change their home directory
echo "Modifying 'newuser' to change home directory..."
sudo usermod -d /home/newuser/newhome newuser

# Create a new group named 'devgroup'
echo "Creating group 'devgroup'..."
sudo groupadd devgroup
echo "Group 'devgroup' created."

# Add 'newuser' to 'devgroup'
echo "Adding 'newuser' to 'devgroup'..."
sudo usermod -aG devgroup newuser
echo "'newuser' added to 'devgroup'."

# Display the users and groups
echo "Displaying users and groups:"
getent passwd | grep newuser
getent group | grep devgroup
