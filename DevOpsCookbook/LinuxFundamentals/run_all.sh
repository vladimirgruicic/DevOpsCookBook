#!/bin/bash

# Ensure log directory exists
mkdir -p /logs

# Log file path
LOG_FILE="/logs/docker_container_logs.txt"

# Clear previous logs
> "$LOG_FILE"

# Running each script and logging output
echo "Running basic_file_operations.sh" | tee -a "$LOG_FILE"
bash /scripts/basic_file_operations.sh >> "$LOG_FILE" 2>&1

echo "Running set_permissions.sh" | tee -a "$LOG_FILE"
bash /scripts/set_permissions.sh >> "$LOG_FILE" 2>&1

echo "Running text_processing.sh" | tee -a "$LOG_FILE"
bash /scripts/text_processing.sh >> "$LOG_FILE" 2>&1

echo "Running bash_scripting_basics.sh" | tee -a "$LOG_FILE"
bash /scripts/bash_scripting_basics.sh >> "$LOG_FILE" 2>&1

echo "All scripts executed. Logs can be found in $LOG_FILE"
