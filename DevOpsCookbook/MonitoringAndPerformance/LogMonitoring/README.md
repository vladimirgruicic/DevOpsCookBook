# Log Monitoring

This directory contains scripts for setting up and managing log monitoring tools on Linux systems.

## Scripts

1. **logwatch_setup.sh**: 
   - Installs and configures Logwatch for log file analysis and reporting.
   - Outputs reports in `/var/log/logwatch`.

2. **graylog_setup.sh**: 
   - Installs and configures Graylog for centralized log management and analysis.
   - Access the Graylog web interface at `http://<your_ip>:9000` after installation.

## Usage

- Make the scripts executable:
  ```bash
  chmod +x logwatch_setup.sh graylog_setup.sh
