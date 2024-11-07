import subprocess
import os

# Get the current directory (root directory of the project)
current_dir = os.path.dirname(os.path.abspath(__file__))
print(f"Current directory: {current_dir}")

# Define the path to the DockerManagement folder
docker_management_dir = os.path.join(current_dir, "DockerManagement")

# Check if the DockerManagement folder exists
if not os.path.exists(docker_management_dir):
    print("Error: 'DockerManagement' folder not found in the root directory.")
    exit(1)

# Run 'pwd' in the DockerManagement directory
print(f"Changing directory to: {docker_management_dir}")
result = subprocess.run(["pwd"], cwd=docker_management_dir, capture_output=True, text=True)

# Print the result of 'pwd' in DockerManagement folder
print(f"Output from DockerManagement directory: {result.stdout.strip()}")

# List and run all Python scripts in the DockerManagement directory
print("\nRunning all Python scripts in the DockerManagement folder:")
for file_name in os.listdir(docker_management_dir):
    if file_name.endswith(".py"):
        script_path = os.path.join(docker_management_dir, file_name)
        print(f"Running {file_name}...")
        
        # Run the script using subprocess
        result = subprocess.run(["python3", script_path], capture_output=True, text=True)
        
        # Print the output of the script
        if result.stdout:
            print(f"Output from {file_name}:\n{result.stdout}")
        if result.stderr:
            print(f"Errors from {file_name}:\n{result.stderr}")
        
        # Check if the script ran successfully
        if result.returncode == 0:
            print(f"{file_name} completed successfully.\n")
        else:
            print(f"{file_name} failed. Please review the output above for details.\n")
