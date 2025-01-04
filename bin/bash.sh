#!/bin/bash

# Simulate a long-running process
long_running_task() {

    echo "Hello, Now Start Executing File"
    echo

    cd "C:/Users/karishma/OneDrive/Desktop/git-green/bin"
    echo "Current Directory: $(pwd)"

    node app.js
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
