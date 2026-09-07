#!/bin/bash

# Disk usage diagnostic tool
# Usage: ./disk-check.sh <threshold> [path]
# Checks filesystem usage against the specified percentage threshold.

# Get the threshold from the first argument
THRESHOLD="$1"

# Get the path from the second argument.
# If no path is provided, use /
PATH_TO_CHECK="${2:-/}"

# Log file location
LOG_FILE="logs/operations.log"


# Check if the threshold was provided
if [ -z "$THRESHOLD" ]; then
    echo "Usage: ./disk-check.sh <threshold> [path]"
    exit 2
fi


# Check if the threshold is an integer
if ! [[ "$THRESHOLD" =~ ^[0-9]+$ ]]; then
    echo "Error: Threshold must be an integer."

    echo "$(date '+%Y-%m-%d %H:%M:%S') - Disk check failed: Invalid threshold '$THRESHOLD'." >> "$LOG_FILE"

    exit 2
fi


# Check if the threshold is between 1 and 100
if (( THRESHOLD < 1 || THRESHOLD > 100 )); then
    echo "Error: Threshold must be between 1 and 100."

    echo "$(date '+%Y-%m-%d %H:%M:%S') - Disk check failed: Threshold '$THRESHOLD' is outside the valid range." >> "$LOG_FILE"

    exit 2
fi


# Check if the path exists
if [ ! -e "$PATH_TO_CHECK" ]; then
    echo "Error: Path does not exist: $PATH_TO_CHECK"

    echo "$(date '+%Y-%m-%d %H:%M:%S') - Disk check failed: Path '$PATH_TO_CHECK' does not exist." >> "$LOG_FILE"

    exit 2
fi


# Get the disk usage percentage
DISK_USAGE=$(df -P "$PATH_TO_CHECK" | awk 'NR==2 {gsub("%","",$5); print $5}')


# Display disk information
echo "================================"
echo "        DISK CHECK"
echo "================================"
echo "Path: $PATH_TO_CHECK"
echo "Disk Usage: ${DISK_USAGE}%"
echo "Threshold: ${THRESHOLD}%"
echo "================================"


# Compare disk usage with threshold
if (( DISK_USAGE >= THRESHOLD )); then

    echo "WARNING: Disk usage has reached or exceeded the threshold."

    # Write the result to the log file
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Disk check on $PATH_TO_CHECK: ${DISK_USAGE}% usage reached or exceeded threshold of ${THRESHOLD}%." >> "$LOG_FILE"

    exit 1

else

    echo "OK: Disk usage is below the threshold."

    # Write the result to the log file
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Disk check on $PATH_TO_CHECK: ${DISK_USAGE}% usage is below threshold of ${THRESHOLD}%." >> "$LOG_FILE"

    exit 0

fi
