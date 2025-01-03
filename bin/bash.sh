#!/bin/bash

# Simulate a long-running process
long_running_task() {

    echo "Hello, Now Start Executing File"
    echo

    command_exists() {
    command -v "$1" &> /dev/null
    }

    # Authenticate if not already done
    if ! gh auth status &> /dev/null; then
        echo "Authenticating GitHub CLI..."
        gh auth login || { echo "Authentication failed."; exit 1; }
    fi
    echo
    
    # Initialize with README
    echo "Initializing repository with README..."
    git add .
    git commit -m "Initial commit"
    git push -u origin main || { echo "Failed to push changes. Exiting."; exit 1; }

    echo "Private repository commited and initialized successfully!"

}

# Function to display the loading animation
loading_animation() {
    local pid=$1  # PID of the background process
    local delay=0.1
    local spinstr='|/-\'

    while kill -0 "$pid" 2>/dev/null; do
        for ((i = 0; i < ${#spinstr}; i++)); do
            printf "\r[%c] Loading..." "${spinstr:i:1}"
            sleep "$delay"
        done
    done
    printf "\r[✔] Done!       \n"
}

# Start the long-running process in the background
long_running_task &

# Get the PID of the background process
task_pid=$!

# Call the loading animation function
loading_animation "$task_pid"
