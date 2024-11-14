#!/bin/bash
# managing_processes.sh

# List all running processes with CPU and memory usage
echo "### Listing all running processes with CPU and memory usage ###"
ps aux --sort=-%cpu | head -n 10  # Show top 10 processes by CPU usage
ps aux --sort=-%mem | head -n 10  # Show top 10 processes by memory usage

# Show the top processes (similar to the `top` command but in non-interactive mode)
echo "### Showing top processes by CPU and memory usage ###"
top -b -n 1 | head -n 20  # Display top 20 processes (non-interactive)

# Create a sample background process and track its resource usage
echo "### Creating a sample background process ###"
sleep 300 &  # This will run for 300 seconds
background_pid=$!
echo "Background process created with PID: $background_pid"

# Monitor the resource usage of the background process
echo "### Monitoring resource usage of the background process (PID: $background_pid) ###"
while ps -p $background_pid > /dev/null; do
    ps -p $background_pid -o pid,etime,%cpu,%mem,comm  # Show CPU and memory usage for the background process
    sleep 1  # Update every second
done

# Kill the sample background process
echo "### Killing the background process (PID: $background_pid) ###"
kill $background_pid

# Confirm the process has been killed
echo "### Confirming the process has been killed ###"
ps aux | grep sleep  # This should return nothing if the process was successfully killed

# Additional: Show the CPU and memory usage for all processes
echo "### Final CPU and memory usage for all processes ###"
ps aux --sort=-%cpu | head -n 10  # Show top 10 processes by CPU usage again after killing background process
ps aux --sort=-%mem | head -n 10  # Show top 10 processes by memory usage again after killing background process
