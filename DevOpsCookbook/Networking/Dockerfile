# Start with a lightweight Linux image
FROM alpine:latest

# Install bash and networking tools
RUN apk update && apk add --no-cache bash iproute2 net-tools iputils bind-tools

# Set the working directory in the container
WORKDIR /scripts

# Copy all shell scripts into the container
COPY ./*.sh /scripts/

# Ensure all scripts are executable
RUN chmod +x /scripts/*.sh

# Set up log directory
RUN mkdir -p /logs

# Create a run_all.sh script to execute all scripts
RUN echo '#!/bin/bash' > /scripts/run_all.sh && \
    echo '/scripts/network_test.sh' >> /scripts/run_all.sh && \
    echo '/scripts/show_active_connections.sh' >> /scripts/run_all.sh && \
    echo '/scripts/show_network_config.sh' >> /scripts/run_all.sh && \
    chmod +x /scripts/run_all.sh

# Default command to run all scripts and keep the container alive
CMD bash /scripts/run_all.sh >> /logs/docker_container_logs.txt 2>&1 && tail -f /logs/docker_container_logs.txt
