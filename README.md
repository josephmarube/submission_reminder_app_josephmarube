Submission Reminder App
# Overview
A simple Bash-based application that reminds students about pending assignment submissions.
It automatically sets up the required files and lets you update assignments dynamically.

# Files
create_environment.sh - Builds the app environment and creates all necessary files.
copilot_shell_script.sh - Updates the assignment name and re-runs the reminder app.
startup.sh - Launches the reminder program. (Auto-created by setup script)

# How to Run

Create the environment
./create_environment.sh


Enter your name when prompted.
A new folder like submission_reminder_joseph/ will be created.

# 3. Run the app
./submission_reminder_joseph/startup.sh

# 4. Update the assignment
./copilot_shell_script.sh


Enter your name and the new assignment (e.g., Git) -- the app will update and rerun automatically.

# Summary

Automates setup and reminders using Bash scripts.

Dynamically changes assignments via copilot_shell_script.sh.

Demonstrates Linux scripting, file management, and Git workflow.
