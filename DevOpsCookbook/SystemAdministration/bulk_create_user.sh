#!/bin/bash

# Path to the user list file
USER_LIST="user_list.txt"
DEFAULT_PASSWORD="temporaryPassword123"  # Set a default temporary password

# Check if the file exists
if [[ ! -f "$USER_LIST" ]]; then
    echo "User list file not found!"
    exit 1
fi

# Clean the file by removing Windows-style line endings (\r) and trimming spaces
sed -i 's/\r//' "$USER_LIST"  # Remove Windows-style line endings
sed -i 's/^[ \t]*//;s/[ \t]*$//' "$USER_LIST"  # Trim leading/trailing spaces

# Loop through each username in the file and create the user
while IFS= read -r user; do
    # Skip empty lines
    if [[ -z "$user" ]]; then
        continue
    fi

    # Check if user already exists
    if id "$user" &>/dev/null; then
        echo "User $user already exists!"
    else
        # Create the user
        useradd "$user"
        # Set a temporary password for the user
        echo "$user:$DEFAULT_PASSWORD" | chpasswd
        # Force the user to change their password on first login
        chage -d 0 "$user"
        echo "User $user created successfully with a temporary password."
    fi
done < "$USER_LIST"
