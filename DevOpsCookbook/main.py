#!/usr/bin/env python3
# main_setup.py - Main script to start the overall setup.

import os
import subprocess
import sys

def handle_error(message):
    print(f"Error: {message}")
    print(f"Current directory: {os.getcwd()}")
    sys.exit(1)

def make_scripts_executable():
    print("Making all scripts executable...")
    try:
        subprocess.check_call(['chmod', '+x', 'make_scripts_executable.sh'])
    except subprocess.CalledProcessError:
        handle_error("Failed to change permissions for make_scripts_executable.sh")

def run_executable_script(script_path):
    print(f"Executing: {script_path}")
    try:
        subprocess.check_call([script_path])
    except subprocess.CalledProcessError:
        handle_error(f"Failed to run {script_path}")

def check_docker_status():
    print("Checking Docker status...")
    try:
        subprocess.check_call(['docker', 'info'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    except subprocess.CalledProcessError:
        handle_error("Docker is not running. Please start Docker before continuing.")

def main_setup():
    make_scripts_executable()
    run_executable_script('./make_scripts_executable.sh')
    check_docker_status()
    print("Starting the Docker setup...")
    run_executable_script('./DockerSetup/docker_setup.sh')
    print("Main setup completed successfully.")

if __name__ == "__main__":
    main_setup()
