#!/bin/bash
# managing_processes.sh

# List all running processes
echo "Listing all running processes:"
ps aux

# Show the top processes
echo "Opening top to show real-time system processes. Press 'q' to exit."
top

# Create a sample background process
echo "Creating a sample background process..."
sleep 300 &  # This will run for 300 seconds
echo "Background process created with PID: $!"

# List processes again to show the new background process
echo "Listing all running processes after creating the background process:"
ps aux | grep sleep

# Kill the sample background process
echo "Killing the background process..."
kill $!

# Confirm the process has been killed
echo "Listing processes to confirm it has been killed:"
ps aux | grep sleep
