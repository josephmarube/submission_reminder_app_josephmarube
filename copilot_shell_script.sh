#!/bin/bash
# ==========================================
# copilot_shell_script.sh
# Updates assignment name in config.env and reruns the reminder app
# ==========================================

# Ask for user name (so we know which folder to use)
read -p "Enter your name (the one used during setup): " username

# Define main directory
BASE_DIR="submission_reminder_${username}"

# Check if the environment exists
if [ ! -d "$BASE_DIR" ]; then
    echo "Error: Directory $BASE_DIR not found. Run create_environment.sh first."
    exit 1
fi

# Ask for new assignment name
read -p "Enter the new assignment name: " new_assignment

CONFIG_FILE="${BASE_DIR}/config/config.env"

# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Config file not found in ${CONFIG_FILE}"
    exit 1
fi

# Replace the ASSIGNMENT value using sed
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"${new_assignment}\"/" "$CONFIG_FILE"

echo
echo "Assignment updated successfully!"
echo "New assignment: ${new_assignment}"
echo "---------------------------------------------"

# Relaunch the reminder app
bash "${BASE_DIR}/startup.sh"

