import os
import subprocess
import sys

def handle_error(message):
    """Print error message and exit."""
    print(f"Error: {message}")
    sys.exit(1)

def execute_script(script_path, log_file):
    """Execute a script and log the output."""
    try:
        with open(log_file, 'w') as log:
            process = subprocess.Popen(script_path, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
            for line in process.stdout:
                log.write(line.decode())
                print(line.decode(), end='')  # Print to console as well
            process.wait()
        if process.returncode != 0:
            handle_error(f"{os.path.basename(script_path)} failed. Check {log_file} for details.")
    except Exception as e:
        handle_error(str(e))

def main():
    # Create logs directory if it doesn’t exist
    os.makedirs("logs", exist_ok=True)
    base_dir = os.path.join(os.getcwd(), "DockerSetup")

    # Step 1: Check if Docker is installed
    if subprocess.call("command -v docker", shell=True) != 0:
        print("Docker is not installed. Executing:", os.path.join(base_dir, "install_docker.sh"))
        execute_script(f"{base_dir}/install_docker.sh", "logs/install_docker.log")
        print("Docker installed successfully.")
    else:
        print("Docker is already installed. Skipping installation.")

    # Step 2: Configure Docker
    print("Executing:", os.path.join(base_dir, "configure_docker.sh"))
    execute_script(f"{base_dir}/configure_docker.sh", "logs/configure_docker.log")
    print("Docker configured successfully.")

    # Step 3: Create Docker containers (if applicable)
    print("Executing:", os.path.join(base_dir, "create_docker_container.sh"))
    execute_script(f"{base_dir}/create_docker_container.sh", "logs/create_docker_container.log")
    print("Docker containers created successfully.")

    # Step 4: Build and run all containers for the project
    print("Building all Docker containers for the project...")
    execute_script(f"{base_dir}/build_all_containers.sh", "logs/build_all_containers.log")
    print("All Docker containers built successfully.")

    print("Docker installation, configuration, and container creation completed successfully.")

if __name__ == "__main__":
    main()
