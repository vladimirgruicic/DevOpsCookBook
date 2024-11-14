#!/bin/bash
# create_group.sh

# Script to create a group

# Prompt for group name and validate input
read -p "Enter group name: " groupname
if [ -z "$groupname" ]; then
    echo "Group name cannot be empty."
    exit 1
fi

# Create the group if it doesn't exist
if getent group "$groupname" > /dev/null; then
    echo "Group '$groupname' already exists."
else
    sudo groupadd "$groupname"
    echo "Group '$groupname' created."
fi
