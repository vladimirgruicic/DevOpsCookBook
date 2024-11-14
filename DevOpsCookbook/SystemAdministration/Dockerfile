# Start with a lightweight Linux image
FROM ubuntu:latest

# Install bash (if needed) and any other dependencies
RUN apt-get update && apt-get install -y bash

# Set the working directory in the container
WORKDIR /scripts

# Copy all shell scripts into the /scripts directory
COPY ./*.sh /scripts/

# Ensure all scripts are executable
RUN chmod +x /scripts/*.sh

# Set up a log directory
RUN mkdir -p /logs

# Default command: keep the container running and log output
CMD tail -f /dev/null
