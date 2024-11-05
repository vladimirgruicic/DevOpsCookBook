#!/bin/bash
# run_all.sh - Script to execute all Linux fundamentals scripts

for script in /scripts/*.sh; do
    echo "Running $script..."
    bash "$script"
done
