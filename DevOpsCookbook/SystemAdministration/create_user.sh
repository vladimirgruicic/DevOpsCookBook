#!/bin/bash
# create_user.sh

# Script to create a user with custom home directory, shell, and group assignment

# Prompt for username and validate input
read -p "Enter username: " username
if [ -z "$username" ]; then
    echo "Username cannot be empty."
    exit 1
fi

# Prompt for home directory with a default value
read -p "Enter home directory (default: /home/$username): " homedir
homedir=${homedir:-/home/$username}

# Prompt for shell with a default value
read -p "Enter shell (default: /bin/bash): " shell
shell=${shell:-/bin/bash}

# Prompt for primary group
read -p "Enter primary group (default: $username): " group
group=${group:-$username}

# Create the group if it doesn't exist
if ! getent group "$group" > /dev/null; then
    sudo groupadd "$group"
    echo "Group '$group' created."
fi

# Create the user with specified home directory, shell, and group
sudo useradd -m -d "$homedir" -s "$shell" -g "$group" "$username"
echo "User '$username' created with home directory '$homedir', shell '$shell', and primary group '$group'."
