# Upgrade all installed packages to the latest version
apt upgrade -y

# Full upgrade of the system (including kernel and major package changes)
apt full-upgrade -y

# Fix broken dependencies in package installations
apt --fix-broken install -y

# Search for a package by name or description
# Replace "curl" with any search term
apt search curl

# Check for available updates without installing them
apt list --upgradable

# Show detailed information about a package (e.g., version, dependencies)
# Replace "curl" with the package you want information about
apt show curl

# Reconfigure an installed package (useful if you need to change configurations)
# Replace "package_name" with the desired package
dpkg-reconfigure package_name

# Remove a package along with its configuration files
# Replace "curl" with the package name
apt purge -y curl

# Clean out the local repository of retrieved package files to free space
apt clean

# Clear the local cache of downloaded package files
apt autoclean

# Display space freed by unused packages
apt autoremove --purge -y

# List package files for a specific installed package (useful for debugging)
# Replace "curl" with any package name
dpkg -L curl

# List files for an uninstalled .deb package
# Replace "package_name.deb" with the .deb file path
dpkg -c package_name.deb

# Show which package installed a specific file
# Replace "/usr/bin/curl" with the path to any file
dpkg -S /usr/bin/curl

# Force reinstall of a package if corrupted
# Replace "curl" with the desired package name
apt install --reinstall -y curl
