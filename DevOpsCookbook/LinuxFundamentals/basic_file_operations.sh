#!/bin/bash
# basic_file_operations.sh

# Navigate to the dev_files directory
cd /home/devuser/dev_files

# Create a sample text file
echo "This is a sample text file." > sample.txt

# List files in the directory
echo "Listing files in the directory:"
ls -la

# Copy the sample file
cp sample.txt sample_copy.txt

# Move the copied file
mv sample_copy.txt sample_moved.txt

# Remove the original sample file
rm sample.txt

# Display message
echo "Basic file operations completed: copied, moved, and deleted a file."
