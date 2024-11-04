#!/bin/bash

# Test connectivity to a specified host
read -p "Enter a hostname or IP address to ping: " host

echo "Pinging $host..."
ping -c 4 "$host"

echo "Traceroute to $host..."
traceroute "$host"
