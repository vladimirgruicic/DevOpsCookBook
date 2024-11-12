#!/bin/bash
# basic_file_operations_manual.sh
# A manual-style script for practicing basic file operations with explanations.

# ========================================
# 1. Navigate to the Target Directory
# ========================================

# Change directory to /home/devuser/dev_files
# Ensure this directory exists or replace it with an appropriate path.
cd /home/devuser/dev_files || { echo "Directory not found"; exit 1; }
echo "Navigated to /home/devuser/dev_files"

# ========================================
# 2. Create a Sample Text File
# ========================================

# Create a text file named sample.txt with content
echo "This is a sample text file." > sample.txt
echo "Created sample.txt with some sample content."

# ========================================
# 3. List Files in the Directory
# ========================================

# List all files in the current directory with detailed information
echo "Listing files in the directory:"
ls -la  # Output: Lists all files, including permissions, owner, size, etc.

# ========================================
# 4. Copy the Sample File
# ========================================

# Copy sample.txt to a new file named sample_copy.txt
cp sample.txt sample_copy.txt
echo "Copied sample.txt to sample_copy.txt."

# ========================================
# 5. Move the Copied File
# ========================================

# Rename (move) sample_copy.txt to sample_moved.txt
mv sample_copy.txt sample_moved.txt
echo "Renamed sample_copy.txt to sample_moved.txt."

# ========================================
# 6. Remove the Original Sample File
# ========================================

# Delete sample.txt from the directory
rm sample.txt
echo "Deleted sample.txt."

# ========================================
# 7. Display Completion Message
# ========================================

# Inform the user that the basic file operations are complete
echo "Basic file operations completed: copied, moved, and deleted a file."

# ========================================
# End of Manual
# ========================================
echo "### End of basic_file_operations_manual.sh ###"
