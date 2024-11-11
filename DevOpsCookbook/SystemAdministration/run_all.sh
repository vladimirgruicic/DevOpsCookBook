#!/bin/bash
# run_all.sh - Executes all scripts and keeps the container running.

LOG_FILE="/logs/docker_container_logs.txt"

echo "Starting execution of SystemAdministration scripts..." | tee -a "$LOG_FILE"

# Iterate over all .sh scripts and execute them
for script in /scripts/*.sh; do
    if [ -x "$script" ]; then
        echo "Running $script..." | tee -a "$LOG_FILE"
        bash "$script" >> "$LOG_FILE" 2>&1
        if [ $? -ne 0 ]; then
            echo "Error running $script. Check $LOG_FILE for details." | tee -a "$LOG_FILE"
        else
            echo "$script executed successfully." | tee -a "$LOG_FILE"
        fi
    else
        echo "Skipping $script as it is not executable." | tee -a "$LOG_FILE"
    fi
done

echo "All scripts executed. Keeping the container alive..." | tee -a "$LOG_FILE"

# Keep the container running by tailing the log file
tail -f "$LOG_FILE"
