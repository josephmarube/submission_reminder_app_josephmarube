#!/bin/bash
# ==========================================
# startup.sh - Launches the Submission Reminder App
# ==========================================
echo "Starting Submission Reminder App..."
cd "$(dirname "$0")"
bash ./app/reminder.sh
