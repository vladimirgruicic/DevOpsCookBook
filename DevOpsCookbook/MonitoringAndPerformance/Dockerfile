# Start with a lightweight Linux image
FROM alpine:latest

# Install bash and any necessary dependencies
RUN apk update && apk add --no-cache bash sysstat procps

# Set the working directory
WORKDIR /scripts

# Copy all shell scripts from subdirectories into the container
COPY ApplicationMonitoring/*.sh /scripts/
COPY LogMonitoring/*.sh /scripts/
COPY PerformanceTuning/*.sh /scripts/
COPY SystemMonitoring/*.sh /scripts/

# Ensure all scripts are executable
RUN chmod +x /scripts/*.sh

# Set up log directory
RUN mkdir -p /logs

# Create a run_all.sh script to execute all scripts
RUN echo '#!/bin/bash' > /scripts/run_all.sh && \
    for script in /scripts/*.sh; do \
        echo "$script" >> /scripts/run_all.sh; \
    done && \
    chmod +x /scripts/run_all.sh

# Default command to run all scripts and keep the container alive
CMD bash /scripts/run_all.sh >> /logs/docker_container_logs.txt 2>&1 && tail -f /logs/docker_container_logs.txt
