# Linux System Administration and User Management

This repository contains scripts for managing essential Linux system administration tasks as well as user and group management. These scripts are tailored for practical scenarios that DevOps engineers may encounter in their daily tasks.

---

## User and Group Management Scripts

This directory contains scripts for managing users and groups on a Linux system.

### Scripts

1. **create_user.sh**
   - Prompts for a username, home directory, and shell to create a new user.
   - **Usage**: `bash create_user.sh`

2. **bulk_create_users.sh**
   - Creates multiple users from a provided file.
   - **Usage**: `bash bulk_create_users.sh <user_list_file>`

3. **user_activity_report.sh**
   - Generates a report of user activity using the `last` command.
   - **Usage**: `bash user_activity_report.sh`

---

## System Administration

This directory contains scripts and explanations related to essential system administration tasks in Linux. The focus is on practical examples that DevOps engineers will encounter in their daily tasks.

### Contents

1. **user_and_group_management.sh**
   - Demonstrates how to create, modify, and delete users and groups in the Linux system.
   - **Usage**: `bash user_and_group_management.sh`

2. **managing_processes.sh**
   - Shows how to manage processes using commands like `ps`, `top`, `kill`, `nice`, and `renice`.
   - **Usage**: `bash managing_processes.sh`

3. **system_logs.sh**
   - Provides methods to view system logs and demonstrates log rotation.
   - **Usage**: `bash system_logs.sh`

4. **package_management.sh**
   - Covers basic package management tasks using package managers like `apt`, `yum`, and `dnf`.
   - **Usage**: `bash package_management.sh`

---

## How to Use the Scripts

1. **Clone the Repository**:
   ```bash
   git clone <repository-url>

chmod +x create_user.sh
chmod +x bulk_create_users.sh
chmod +x user_activity_report.sh
chmod +x user_and_group_management.sh
chmod +x managing_processes.sh
chmod +x system_logs.sh
chmod +x package_management.sh

./create_user.sh
./bulk_create_users.sh <user_list_file>
./user_activity_report.sh
./user_and_group_management.sh
./managing_processes.sh
./system_logs.sh
./package_management.sh
