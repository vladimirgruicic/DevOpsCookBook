#!/bin/bash
# set_permissions_manual.sh
# A manual-style script for setting up permissions on a directory, with explanations.

# ========================================
# 1. Create a New Directory
# ========================================

# Create a directory at /home/devuser/dev_files for development files
# Ensure the parent path exists or adjust as needed
echo "Creating directory '/home/devuser/dev_files'..."
mkdir -p /home/devuser/dev_files  # -p creates any missing parent directories
echo "Directory '/home/devuser/dev_files' created."

# ========================================
# 2. Change Ownership
# ========================================

# Change the ownership of /home/devuser/dev_files to the user 'devuser' and group 'devteam'
# Requires sudo privileges
echo "Changing ownership of '/home/devuser/dev_files' to 'devuser:devteam'..."
sudo chown devuser:devteam /home/devuser/dev_files
echo "Ownership changed to 'devuser:devteam'."

# ========================================
# 3. Set Directory Permissions
# ========================================

# Set permissions for /home/devuser/dev_files:
# - Owner (user) has read, write, and execute (7)
# - Group has read and execute (5)
# - Others have read and execute (5)
# The result is 755 permissions
echo "Setting permissions for '/home/devuser/dev_files' to 755..."
chmod 755 /home/devuser/dev_files
echo "Permissions set to 755 (rwxr-xr-x)."

# ========================================
# 4. Display Completion Message
# ========================================

# Inform the user that the setup is complete
echo "Directory '/home/devuser/dev_files' created with appropriate permissions."

# ========================================
# End of Manual
# ========================================
echo "### End of set_permissions_manual.sh ###"
