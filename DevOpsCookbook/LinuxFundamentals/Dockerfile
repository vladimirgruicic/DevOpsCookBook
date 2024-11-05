# Start with a lightweight Linux image
FROM alpine:latest

# Install bash (if needed) and any other dependencies
RUN apk update && apk add bash

# Set the working directory in the container
WORKDIR /scripts

# Copy all Linux fundamentals scripts into the container
COPY *.sh /scripts/

# Make all scripts executable
RUN chmod +x /scripts/*.sh

# Default command to run all scripts
CMD ["bash", "/scripts/run_all.sh"]
