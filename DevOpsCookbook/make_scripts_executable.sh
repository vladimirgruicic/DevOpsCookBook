#!/bin/bash
# make_scripts_executable.sh - Makes all scripts in the DevOpsCookbook executable.

# Function to handle errors
handle_error() {
    echo "Error: $1"
    exit 1
}

# Base directory for the scripts
BASE_DIR="$(pwd)/DevOpsCookbook"

# List of directories containing scripts
SCRIPT_DIRS=(
    "$BASE_DIR/LinuxFundamentals"
    "$BASE_DIR/SystemAdministration"
    "$BASE_DIR/Networking"
    "$BASE_DIR/DockerSetup"
    "$BASE_DIR/MonitoringAndPerformance/SystemMonitoring"
    "$BASE_DIR/MonitoringAndPerformance/ApplicationMonitoring"
    "$BASE_DIR/MonitoringAndPerformance/LogMonitoring"
    "$BASE_DIR/MonitoringAndPerformance/PerformanceTuning"
    "$BASE_DIR/AutomationAndConfigurationManagement"
)

# Iterate over each directory and make scripts executable
for dir in "${SCRIPT_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        echo "Processing directory: $dir"
        for script in "$dir"/*.sh; do
            if [ -f "$script" ]; then
                chmod +x "$script" || handle_error "Failed to make $script executable."
                echo "Made $script executable."
            fi
        done
    else
        echo "Directory $dir does not exist."
    fi
done

echo "All scripts have been made executable."
