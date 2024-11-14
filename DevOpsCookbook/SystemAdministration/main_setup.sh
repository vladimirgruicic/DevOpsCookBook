#!/bin/bash
# main_setup.sh
# Orchestrates the creation of users, groups, project structure, package installation, and setting of permissions.

# Function to handle errors
handle_error() {
    echo "Error: $1"
    exit 1
}

# Step 1: Run the group creation script
echo "Running bulk create group script..."
./bulk_create_group.sh || handle_error "Failed to create groups."

# Step 2: Run the user creation script
echo "Running bulk create user script..."
./bulk_create_user.sh || handle_error "Failed to create users."

# Step 3: Run the package management script
echo "Running package management script..."
./package_management.sh || handle_error "Failed to install packages."

# Step 5: Run the project structure creation script
echo "Running project structure creation script..."
./create_project_structure.sh || handle_error "Failed to create project structure."

# Step 6: Run the permissions setup script (if applicable)
# You can add this line if you need to set up permissions afterward
# echo "Running permissions setup script..."
# ./set_project_permissions.sh || handle_error "Failed to set project permissions."

echo "Project setup completed successfully."
