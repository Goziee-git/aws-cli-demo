#!/bin/bash

LOGFILE="$HOME/ssh_audit.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Defaults
KEY_USED=""
USER_HOST=""
EXTRA_ARGS=()

# Parse arguments manually to capture the key and host
while [[ $# -gt 0 ]]; do
  case "$1" in
    -i)
      KEY_USED="$2"
      shift 2
      ;;
    -*)
      EXTRA_ARGS+=("$1")
      shift
      ;;
    *)
      USER_HOST="$1"
      shift
      ;;
  esac
done

# Build the SSH command
SSH_CMD=(ssh "${EXTRA_ARGS[@]}" ${KEY_USED:+-i "$KEY_USED"} "$USER_HOST")

# Log attempt
echo "[$TIMESTAMP] Attempting SSH to $USER_HOST using key: ${KEY_USED:-'default'}" >> "$LOGFILE"

# Run SSH
"${SSH_CMD[@]}"
RESULT=$?

# Log result
if [ $RESULT -eq 0 ]; then
  echo "[$TIMESTAMP] SUCCESS: SSH to $USER_HOST" >> "$LOGFILE"
else
  echo "[$TIMESTAMP] FAILURE: SSH to $USER_HOST (exit code $RESULT)" >> "$LOGFILE"
fi
