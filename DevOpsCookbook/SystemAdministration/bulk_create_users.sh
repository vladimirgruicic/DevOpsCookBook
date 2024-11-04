#!/bin/bash

# Bulk user creation from a file
if [ $# -ne 1 ]; then
    echo "Usage: $0 <user_list_file>"
    exit 1
fi

user_list=$1

while IFS= read -r username; do
    sudo useradd -m "$username"
    echo "User $username created."
done < "$user_list"
