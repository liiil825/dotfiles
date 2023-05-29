#!/usr/bin/env bash

PIDFILE=/tmp/mimic.lock

# If the lock is already held by another process, find its PID and kill it
if [ -f "${PIDFILE}" ]; then
  read -r pid <"${PIDFILE}"
  if kill -0 "${pid}" 2>/dev/null; then
    echo "Killing existing process"
    kill -9 "${pid}"
    sleep 1 # This gives the system a moment to fully kill the process
    rm "${PIDFILE}"
    exit 0
  fi
fi

# Attempt to acquire an exclusive lock. Launch the command, capture the PID, and store it in the PIDFILE
(
  flock -n 200

  # mimic -t "$(wl-paste)" -voice slt &
  curl -X POST -H 'Content-Type: text/plain' --output - \
    --data "$(wl-paste)" \
    'http://localhost:5002/api/tts' |
    aplay &
  echo $! >"${PIDFILE}"
) 200>"${PIDFILE}"
