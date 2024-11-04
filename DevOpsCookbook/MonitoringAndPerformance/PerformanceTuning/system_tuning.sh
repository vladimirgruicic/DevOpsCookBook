#!/bin/bash
# system_tuning.sh - Provides methods for tuning system performance based on resource usage.

echo "Starting system performance tuning..."

echo "1. Adjusting Swappiness..."
sudo sysctl vm.swappiness=10
echo "Swappiness set to 10 (reduces swap usage)."

echo "2. Setting CPU governor to performance..."
sudo cpupower frequency-set -g performance
echo "CPU governor set to performance mode."

echo "3. Optimizing I/O Scheduler..."
echo "Choosing 'deadline' as I/O scheduler..."
echo deadline | sudo tee /sys/block/sda/queue/scheduler
echo "I/O Scheduler set to deadline."

echo "4. Tuning file descriptors..."
echo "Setting maximum number of open file descriptors to 65536..."
sudo bash -c 'echo "fs.file-max = 65536" >> /etc/sysctl.conf'
sudo sysctl -p

echo "System performance tuning complete!"
