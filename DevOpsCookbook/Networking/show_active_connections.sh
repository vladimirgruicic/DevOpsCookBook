#!/bin/bash

# Display active connections
echo "Active Connections:"
netstat -tuln  # Or use 'ss -tuln' for a more modern approach
