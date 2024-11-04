
### Sample Scripts

#### nagios_setup.sh
Here’s a basic script for installing Nagios. This will set up Nagios Core on a typical Ubuntu system.

```bash
#!/bin/bash
# nagios_setup.sh - Installs and configures Nagios on Ubuntu.

echo "Updating package index..."
sudo apt-get update -y

echo "Installing required packages..."
sudo apt-get install -y autoconf gcc libgd2-xpm-dev make gettext wget

echo "Creating Nagios user and group..."
sudo useradd nagios
sudo useradd -r nagios

echo "Installing Nagios..."
cd /tmp
wget https://github.com/NagiosEnterprises/nagioscore/archive/release-4.4.6.tar.gz
tar -xzf release-4.4.6.tar.gz
cd nagioscore-release-4.4.6
./configure --with-command-group=nagios
make all
sudo make install

echo "Configuring Nagios..."
sudo make install-init
sudo make install-config
sudo make install-commandmode

echo "Setting up web interface..."
sudo make install-webconf
sudo a2enmod rewrite
sudo systemctl restart apache2

echo "Nagios installation complete! Access it at http://<YOUR_SERVER_IP>/nagios"
