#!/bin/bash
# create_project_structure.sh
# Creates a directory structure for the project with development, staging, and production environments.

PROJECT_DIR="/project"
ENVIRONMENTS=("dev" "staging" "prod")

# Create the base project directory
mkdir -p "$PROJECT_DIR" || { echo "Failed to create project directory."; exit 1; }

# Create environment-specific directories
for env in "${ENVIRONMENTS[@]}"; do
    ENV_DIR="$PROJECT_DIR/$env"
    mkdir -p "$ENV_DIR"
    echo "Created environment directory: $ENV_DIR"
done

echo "Project structure created successfully."
