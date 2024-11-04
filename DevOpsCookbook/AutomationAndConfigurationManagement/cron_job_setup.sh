#!/bin/bash
# cron_job_setup.sh - Script to set up a cron job

# Function to handle errors
handle_error() {
    echo "Error: $1"
    exit 1
}

# Define the cron job command
CRON_JOB="* * * * * /path/to/your/script.sh"

# Add the cron job
(crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab - || handle_error "Failed to set up cron job."

echo "Cron job has been set up successfully."
