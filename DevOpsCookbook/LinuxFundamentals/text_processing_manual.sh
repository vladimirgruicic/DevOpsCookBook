#!/bin/bash
# text_processing_manual.sh
# A manual-style script for practicing basic text processing commands.

# ========================================
# 1. Create a Sample Log File
# ========================================

# Create a sample log file named log.txt with entries for INFO, ERROR, and WARNING messages.
# The -e option enables interpretation of backslash escapes (\n for newline).
echo "Creating sample log file with entries..."
echo -e "INFO: Everything is running smoothly.\nERROR: Something went wrong!\nWARNING: Check your configuration." > /home/devuser/dev_files/log.txt
echo "Sample log file 'log.txt' created at /home/devuser/dev_files/."

# ========================================
# 2. Search for ERROR Messages Using grep
# ========================================

# Use grep to search for lines containing the word "ERROR" in log.txt.
# This command filters the log file to display only the lines with ERROR messages.
echo "Searching for ERROR messages in the log file:"
grep "ERROR" /home/devuser/dev_files/log.txt  # Output: Lines containing "ERROR"
# Example Output: ERROR: Something went wrong!

# ========================================
# End of Manual
# ========================================
echo "### End of text_processing_manual.sh ###"
