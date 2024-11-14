# Start with a lightweight Linux image
FROM ubuntu:latest

# Install bash (if needed) and any other dependencies
RUN apk update && apk add bash

# Set the working directory in the container
WORKDIR /scripts

COPY ./*.sh /scripts/

# Ensure all scripts are executable
RUN chmod +x /scripts/*.sh

# Set up log directory
RUN mkdir -p /logs

# Default command to run all scripts and keep the container alive
CMD bash /scripts/run_all.sh >> /logs/docker_container_logs.txt 2>&1 && tail -f /logs/docker_container_logs.txt
