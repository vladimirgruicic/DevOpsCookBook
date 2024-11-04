#!/bin/sh
# keep_alive.sh - Keeps the container alive and creates a status file.

# Create a status file to indicate the script is running
touch /tmp/keep_alive_status.txt

# Simulate a long-running process or keep alive
while true; do
    sleep 60  # Keep the script running by sleeping indefinitely
done
