# Linux Fundamentals

This directory contains scripts and explanations related to fundamental Linux commands and operations. The focus is on practical examples that DevOps engineers will encounter in their daily tasks.

## Contents

1. **create_users_and_groups.sh**
   - This script creates users and groups to manage access and permissions within the system.
   - **Users Created**: `devuser`, `testuser`
   - **Group Created**: `devteam`

2. **set_permissions.sh**
   - This script creates a directory and sets its permissions to ensure that only authorized users can modify its contents.

3. **basic_file_operations.sh**
   - This script demonstrates basic file operations such as creating, copying, moving, and deleting files.

4. **text_processing.sh**
   - This script showcases text processing capabilities using `grep` to filter log entries.

5. **bash_scripting_basics.sh**
   - This script introduces basic Bash scripting concepts, including variables, loops, and functions for automation tasks.

## How to Use the Scripts

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/yourusername/DevOps-Linux-Cookbook.git
   cd DevOps-Linux-Cookbook/1_Linux_Fundamentals


## Prerequisites

- An Azure VM or any Linux server to run the scripts.
- SSH access to the server.

chmod +x create_users_and_groups.sh
chmod +x set_permissions.sh
chmod +x basic_file_operations.sh
chmod +x text_processing.sh

./create_users_and_groups.sh
./set_permissions.sh
./basic_file_operations.sh
./text_processing.sh
