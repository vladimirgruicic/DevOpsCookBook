#!/bin/bash
# package_management.sh

# Define the file containing the list of packages to install
PACKAGE_FILE="packages.txt"

# Check if the package file exists
if [[ ! -f "$PACKAGE_FILE" ]]; then
    echo "Error: Package file '$PACKAGE_FILE' not found!"
    exit 1
fi

# Clean the package file by removing Windows-style line endings (\r) and trimming spaces
echo "Cleaning up package file..."
sed -i 's/\r//' "$PACKAGE_FILE"  # Remove Windows-style line endings
sed -i 's/^[ \t]*//;s/[ \t]*$//' "$PACKAGE_FILE"  # Trim leading/trailing spaces

# Update the package index
echo "Updating package index..."
sudo apt update

# Install each package listed in the package file
echo "Installing packages from $PACKAGE_FILE..."
while IFS= read -r package || [[ -n "$package" ]]; do
    # Ignore empty lines and comments
    [[ -z "$package" || "$package" =~ ^# ]] && continue
    
    # Install the package
    echo "Installing '$package'..."
    sudo apt install -y "$package"
    
    # Verify the installation
    if dpkg -l | grep -q "^ii  $package"; then
        echo "'$package' installed successfully."
    else
        echo "Failed to install '$package'."
    fi
done < "$PACKAGE_FILE"

# Clean up unused packages
echo "Cleaning up unused packages..."
sudo apt autoremove -y

echo "Package management operations completed."
