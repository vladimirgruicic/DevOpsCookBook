#!/bin/bash
# bash_scripting_basics.sh
# This script introduces basic Bash scripting concepts, including variables, loops, and functions.

# 1. Variables
# Defining and using variables in a script
echo "### Variables ###"
greeting="Hello, DevOps Engineer!"
echo "$greeting"

# 2. Using Command Substitution
# Storing the result of a command in a variable
current_date=$(date)
echo "Current date and time: $current_date"

# 3. Conditional Statements
# Using if-else to check for a condition
echo "### Conditional Statements ###"
number=10
if [ "$number" -gt 5 ]; then
    echo "$number is greater than 5"
else
    echo "$number is not greater than 5"
fi

# 4. Loops
# Using a for loop to iterate over a list of items
echo "### Loops ###"
for i in {1..5}; do
    echo "Loop iteration: $i"
done

# 5. Functions
# Defining and calling a function
echo "### Functions ###"
function greet_user() {
    local name=$1
    echo "Hello, $name!"
}

# Calling the function with an argument
greet_user "DevOps Specialist"

# 6. Reading User Input
# Prompting the user for input and storing it in a variable
echo "### User Input ###"
read -p "Enter your favorite Linux command: " fav_command
echo "Your favorite Linux command is: $fav_command"

# 7. Command-line Arguments
# Accessing arguments passed to the script
echo "### Command-line Arguments ###"
if [ $# -gt 0 ]; then
    echo "Script arguments: $@"
else
    echo "No arguments provided."
fi

# 8. Exit Status
# Demonstrating the exit status of a command
echo "### Exit Status ###"
ls /nonexistent_directory
if [ $? -ne 0 ]; then
    echo "The last command failed with a non-zero exit status."
fi

# End of script
echo "### End of bash_scripting_basics.sh ###"
