#!/bin/bash

# Create a user with a specific home directory and shell
read -p "Enter username: " username
read -p "Enter home directory (default: /home/$username): " homedir
homedir=${homedir:-/home/$username}
read -p "Enter shell (default: /bin/bash): " shell
shell=${shell:-/bin/bash}

sudo useradd -m -d "$homedir" -s "$shell" "$username"
echo "User $username created with home directory $homedir and shell $shell."
