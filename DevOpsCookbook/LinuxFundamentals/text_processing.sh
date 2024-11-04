#!/bin/bash
# text_processing.sh

# Create a sample log file with some entries
echo -e "INFO: Everything is running smoothly.\nERROR: Something went wrong!\nWARNING: Check your configuration." > /home/devuser/dev_files/log.txt

# Use grep to search for ERROR messages in the log file
echo "Searching for ERROR messages in the log file:"
grep "ERROR" /home/devuser/dev_files/log.txt
