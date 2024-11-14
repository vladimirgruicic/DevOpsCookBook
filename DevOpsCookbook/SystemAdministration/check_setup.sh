#!/bin/bash

# Function to list all users
list_users() {
    echo "Listing all users:"
    cut -d: -f1 /etc/passwd
}

# Function to list all groups
list_groups() {
    echo "Listing all groups:"
    cut -d: -f1 /etc/group
}

# Function to list installed packages
list_installed_packages() {
    echo "Listing installed packages:"
    dpkg -l | awk '{print $2}'
}

# Example usage:
echo "==== Users, Groups, and Packages Check ===="
echo

# List all users and groups
list_users
echo
list_groups
echo

# List installed packages
list_installed_packages

echo "Setup check completed."
