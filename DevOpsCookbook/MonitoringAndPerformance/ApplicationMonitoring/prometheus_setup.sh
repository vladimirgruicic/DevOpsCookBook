#!/bin/bash
# prometheus_setup.sh - Installs and configures Prometheus on Ubuntu.

echo "Updating package index..."
sudo apt-get update -y

echo "Installing Prometheus..."
cd /tmp
wget https://github.com/prometheus/prometheus/releases/download/v2.38.0/prometheus-2.38.0.linux-amd64.tar.gz
tar -xzf prometheus-2.38.0.linux-amd64.tar.gz
sudo mv prometheus-2.38.0.linux-amd64/prometheus /usr/local/bin/
sudo mv prometheus-2.38.0.linux-amd64/promtool /usr/local/bin/

echo "Creating Prometheus user..."
sudo useradd --no-create-home --shell /bin/false prometheus

echo "Creating directories..."
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus

echo "Setting permissions..."
sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus

echo "Copying configuration files..."
sudo mv prometheus-2.38.0.linux-amd64/prometheus.yml /etc/prometheus/prometheus.yml
sudo chown prometheus:prometheus /etc/prometheus/prometheus.yml

echo "Creating systemd service file..."
cat <<EOF | sudo tee /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus/

[Install]
WantedBy=multi-user.target
EOF

echo "Starting and enabling Prometheus..."
sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl enable prometheus

echo "Prometheus installation complete! Access it at http://<YOUR_SERVER_IP>:9090"
