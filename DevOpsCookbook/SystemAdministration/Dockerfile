# Start with a lightweight Linux image
FROM ubuntu:latest

# Install bash and any other dependencies
RUN apt-get update && apt-get install -y bash

# Set the working directory in the container
WORKDIR /scripts

# Copy all files to the /scripts directory in the container
COPY . /scripts/

# Ensure all shell scripts are executable
RUN chmod +x /scripts/*.sh

# Set up a log directory for storing log output
RUN mkdir -p /logs

# Run the main setup script and keep the container alive, logging output to a log file
CMD bash /scripts/main_setup.sh >> /logs/container_setup.log 2>&1 && tail -f /logs/container_setup.log
