#!/bin/bash
# bash_scripting_basics_manual.sh
# This is a manual-style script for learning Bash basics, with each command commented.

# ========================================
# 1. Variables
# ========================================

# Define a simple variable
greeting="Hello, DevOps Engineer!"

# Print the variable's value
echo "### Variables ###"
echo "$greeting"  # Output: Hello, DevOps Engineer!

# ========================================
# 2. Command Substitution
# ========================================

# Store the current date and time in a variable using command substitution
current_date=$(date)

# Print the current date and time
echo "### Command Substitution ###"
echo "Current date and time: $current_date"  # Output: Current date and time: [Date and Time]

# ========================================
# 3. Conditional Statements
# ========================================

# Define a number and use an if-else statement to check if it's greater than 5
number=10
echo "### Conditional Statements ###"
if [ "$number" -gt 5 ]; then
    echo "$number is greater than 5"
else
    echo "$number is not greater than 5"
fi
# Output: 10 is greater than 5

# ========================================
# 4. Loops
# ========================================

# Use a for loop to print a message 5 times
echo "### Loops ###"
for i in {1..5}; do
    echo "Loop iteration: $i"  
done

# ========================================
# 5. Functions
# ========================================

# Define a function that greets a user
echo "### Functions ###"
function greet_user() {
    local name=$1
    echo "Hello, $name!"
}

# Call the function with an argument
greet_user "DevOps Specialist"  # Output: Hello, DevOps Specialist!

# ========================================
# 6. User Input (Skip if running in a non-interactive environment)
# ========================================

# Prompt the user for input and store it in a variable
# Commented out for non-interactive environments. Use 'read' in a terminal session.
# read -p "Enter your favorite Linux command: " fav_command
# echo "Your favorite Linux command is: $fav_command"

# Alternatively, set a default for non-interactive use:
fav_command=${fav_command:-"ls"}
echo "Your favorite Linux command is: $fav_command"

# ========================================
# 7. Command-line Arguments
# ========================================

# Check if arguments are passed to the script and print them
echo "### Command-line Arguments ###"
if [ $# -gt 0 ]; then
    echo "Script arguments: $@"  # Output: Script arguments: [arg1 arg2 ...]
else
    echo "No arguments provided."
fi

# ========================================
# 8. Exit Status
# ========================================

# Demonstrate checking the exit status of a command
echo "### Exit Status ###"
ls /nonexistent_directory  # This command will fail

# Check the exit status of the previous command
if [ $? -ne 0 ]; then
    echo "The last command failed with a non-zero exit status."
else
    echo "The last command succeeded with a zero exit status."
fi

# ========================================
# End of Manual
# ========================================
echo "### End of bash_scripting_basics_manual.sh ###"
