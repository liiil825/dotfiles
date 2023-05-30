#!/usr/bin/env bash

PIDFILE=/tmp/speak.lock
RUNFILE=/tmp/speak-run.lock

# If the lock is already held by another process, find its PID and kill it
if [ -f "${PIDFILE}" ]; then
  read -r pid <"${PIDFILE}"
  if kill -0 "${pid}" 2>/dev/null; then
    echo "Killing existing process"
    kill -9 "${pid}"
    rm "${RUNFILE}"
    sleep 0.1 # This gives the system a moment to fully kill the process
    rm "${PIDFILE}"
    exit 0
  fi
fi

# Attempt to acquire an exclusive lock. Launch the command, capture the PID, and store it in the PIDFILE
(
  flock -n 200

  data=$(wl-paste | sed -e 's#[^.]$#.#' -e 's#\###g;s#//##g; s#--##g;' | sed -e ':a;N;$!ba;s#\n# #g')

  # Split the data text according to period (.)
  IFS='.' read -ra sentences <<<"$data"
  touch $RUNFILE
  echo 'run speak'
  for sentence in "${sentences[@]}"; do
    if [ ! -e "${RUNFILE}" ]; then
      break
    fi
    echo "$sentence."
    curl -X POST -H 'Content-Type: text/plain' --output - \
      --data "$sentence." \
      'http://localhost:5002/api/tts' |
      aplay &
    echo $! >"${PIDFILE}"
    wait $!
  done

) 200>"${PIDFILE}"
