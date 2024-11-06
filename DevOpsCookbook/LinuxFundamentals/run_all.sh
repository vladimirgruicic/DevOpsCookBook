# LinuxFundamentals/run_all.sh

# Redirecting script outputs to logs
echo "Running basic_commands.sh" >> /logs/docker_container_logs.txt
bash /scripts/basic_commands.sh >> /logs/docker_container_logs.txt 2>&1

echo "Running file_permissions.sh" >> /logs/docker_container_logs.txt
bash /scripts/file_permissions.sh >> /logs/docker_container_logs.txt 2>&1

echo "Running text_processing.sh" >> /logs/docker_container_logs.txt
bash /scripts/text_processing.sh >> /logs/docker_container_logs.txt 2>&1

echo "Running bash_scripting_basics.sh" >> /logs/docker_container_logs.txt
bash /scripts/bash_scripting_basics.sh >> /logs/docker_container_logs.txt 2>&1
