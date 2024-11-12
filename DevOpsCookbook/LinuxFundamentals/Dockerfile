# Start with a lightweight Linux image
FROM alpine:latest

# Install bash (if needed) and any other dependencies
RUN apk update && apk add bash

# Set the working directory in the container
WORKDIR /scripts

# Copy all shell scripts into the /scripts directory
COPY ./*.sh /scripts/

# Ensure all scripts are executable
RUN chmod +x /scripts/*.sh

# Set up a log directory
RUN mkdir -p /logs

# Default command: start a bash session in interactive mode and log any output,
# while keeping the container alive
CMD tail -f /dev/null
