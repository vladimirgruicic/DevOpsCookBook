#!/bin/bash
# logwatch_setup.sh - Configures Logwatch for log file analysis and reporting.

echo "Installing Logwatch..."
sudo apt-get update -y
sudo apt-get install -y logwatch

echo "Configuring Logwatch..."
# You can customize Logwatch settings here
sudo cp /usr/share/logwatch/default.conf/logwatch.conf /etc/logwatch/conf/logwatch.conf

echo "Logwatch installation and configuration complete!"
echo "You can view reports in /var/log/logwatch."
