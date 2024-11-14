#!/bin/bash

# Path to the group list file
GROUP_LIST="group_list.txt"

# Check if the file exists
if [[ ! -f "$GROUP_LIST" ]]; then
    echo "Group list file not found!"
    exit 1
fi

# Clean the file by removing Windows-style line endings (\r) and trimming spaces
sed -i 's/\r//' "$GROUP_LIST"  # Remove Windows-style line endings
sed -i 's/^[ \t]*//;s/[ \t]*$//' "$GROUP_LIST"  # Trim leading/trailing spaces

# Loop through each group name in the file and create the group
while IFS= read -r group; do
    # Skip empty lines
    if [[ -z "$group" ]]; then
        continue
    fi

    # Check if group already exists
    if getent group "$group" &>/dev/null; then
        echo "Group $group already exists!"
    else
        # Create the group
        groupadd "$group"
        echo "Group $group created successfully."
    fi
done < "$GROUP_LIST"
