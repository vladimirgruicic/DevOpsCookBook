#!/bin/bash
# system_logs.sh

# View the system log file
echo "Viewing the syslog:"
sudo tail -n 20 /var/log/syslog

# View the authentication log
echo "Viewing the authentication log:"
sudo tail -n 20 /var/log/auth.log

# Create a log rotation configuration (if not already existing)
echo "Configuring log rotation for test.log..."
echo "/var/log/test.log {
    rotate 5
    daily
    compress
}" | sudo tee /etc/logrotate.d/testlog

# Creating a sample log file
echo "Creating a sample log file..."
echo "This is a test log entry." | sudo tee /var/log/test.log

# Force log rotation
echo "Forcing log rotation..."
sudo logrotate -f /etc/logrotate.d/testlog

# Display the content of the log after rotation
echo "Displaying contents of test.log after rotation:"
sudo cat /var/log/test.log
