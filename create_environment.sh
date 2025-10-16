#!/bin/bash

# create_environment.sh
# Builds the full Submission Reminder App environment from scratch

# Prompt user for their name
read -p "Enter your name: " username

# Define main directory
BASE_DIR="submission_reminder_${username}"

echo "Creating Submission Reminder environment for $username ..."
mkdir -p "${BASE_DIR}/app"
mkdir -p "${BASE_DIR}/modules"
mkdir -p "${BASE_DIR}/assets"
mkdir -p "${BASE_DIR}/config"

# Create functions.sh

cat << 'EOF' > "${BASE_DIR}/modules/functions.sh"
#!/bin/bash
# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF


# Create reminder.sh
cat << 'EOF' > "${BASE_DIR}/app/reminder.sh"
#!/bin/bash
# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF

# Create config.env

cat << 'EOF' > "${BASE_DIR}/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# Create submissions.txt

cat << 'EOF' > "${BASE_DIR}/assets/submissions.txt"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Faith, Shell Navigation, not submitted
Kevin, Git, submitted
Brian, Shell Basics, not submitted
Mercy, Shell Navigation, submitted
Allan, Git, not submitted
EOF

# Create startup.sh

cat << 'EOF' > "${BASE_DIR}/startup.sh"
#!/bin/bash
# ==========================================
# startup.sh - Launches the Submission Reminder App
# ==========================================
echo "Starting Submission Reminder App..."
cd "$(dirname "$0")"
bash ./app/reminder.sh
EOF


# Make all .sh files executable

find "${BASE_DIR}" -type f -name "*.sh" -exec chmod +x {} \;

echo
echo "Environment setup complete!"
echo "Your app has been created in: ${BASE_DIR}/"
echo
echo "To start the app, run:"
echo "  ./submission_reminder_${username}/startup.sh"

