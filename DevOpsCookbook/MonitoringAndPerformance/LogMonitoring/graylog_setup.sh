#!/bin/bash
# graylog_setup.sh - Installs and configures Graylog for log management.

echo "Installing Java (required for Graylog)..."
sudo apt-get update -y
sudo apt-get install -y openjdk-11-jre

echo "Installing MongoDB..."
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/multiverse amd64 mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt-get update -y
sudo apt-get install -y mongodb-org

echo "Installing Elasticsearch..."
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get update -y
sudo apt-get install -y elasticsearch

echo "Installing Graylog..."
wget https://packages.graylog2.org/repo/deb/graylog-4.0-repository.deb
sudo dpkg -i graylog-4.0-repository.deb
sudo apt-get update -y
sudo apt-get install -y graylog-server

echo "Configuring Graylog..."
# Update the Graylog configuration
sudo sed -i "s/#http_bind_address = 127.0.0.1:9000/http_bind_address = 0.0.0.0:9000/" /etc/graylog/server/server.conf

echo "Starting services..."
sudo systemctl start mongodb
sudo systemctl start elasticsearch
sudo systemctl start graylog-server

echo "Graylog installation complete!"
echo "Access the Graylog web interface at http://<your_ip>:9000"
