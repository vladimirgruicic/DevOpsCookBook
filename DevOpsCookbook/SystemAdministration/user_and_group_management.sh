#!/bin/bash
# user_and_group_management.sh
# A script to create groups, create users, and assign users to groups

# Function to create a group
create_group() {
    local groupname=$1
    if ! getent group "$groupname" > /dev/null; then
        sudo groupadd "$groupname"
        echo "Group '$groupname' created."
    else
        echo "Group '$groupname' already exists."
    fi
}

# Function to create a user and assign to a group
create_user() {
    local username=$1
    local homedir=$2
    local shell=$3
    local group=$4

    # Create the user
    sudo useradd -m -d "$homedir" -s "$shell" -g "$group" "$username"
    echo "User '$username' created with home directory '$homedir', shell '$shell', and assigned to group '$group'."
}

# Function to process the group list and create groups
create_groups() {
    local group_list=$1
    while IFS= read -r groupname; do
        if [ -n "$groupname" ]; then
            create_group "$groupname"
        fi
    done < "$group_list"
}

# Function to process the user list and create users with assignments
create_users() {
    local user_list=$1
    while IFS=',' read -r username homedir shell group; do
        if [ -n "$username" ]; then
            homedir=${homedir:-/home/$username}
            shell=${shell:-/bin/bash}
            group=${group:-$username}

            # Create the user and assign to the group
            create_user "$username" "$homedir" "$shell" "$group"
        fi
    done < "$user_list"
}

# Main function to control the flow of the script
main() {
    if [ $# -ne 2 ]; then
        echo "Usage: $0 <group_list_file> <user_list_file>"
        exit 1
    fi

    group_list=$1
    user_list=$2

    # Create groups
    echo "Creating groups..."
    create_groups "$group_list"

    # Create users and assign to groups
    echo "Creating users and assigning them to groups..."
    create_users "$user_list"

    echo "User and group management completed."
}

# Run the script
main "$@"
