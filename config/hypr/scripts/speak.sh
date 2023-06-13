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

copy_translate() {
  [[ ! -z $(wl-paste) ]] && wl-copy "$(trans -b :zh-Cn "$(wl-paste)")"
}

replace_data() {
  data=$(wl-paste)
  [[ -z $data ]] && data="The system clipobard is empty."
  data=$(echo "$data" | sd -s '#' '')
  data=$(echo "$data" | sd -s '/' '')
  data=$(echo "$data" | sd -s '\-\-' '')
  data=$(echo "$data" | sd -s '...' ' et cetera')
  data=$(echo "$data" | sd '(\d+)\.' '$1')
  data=$(echo "$data" | sd '([^.])\n' '$1.')
  data=$(echo "$data" | sd '\n' '.')
  data=$(echo "$data" | sd -s '..' '.')
  echo $data
}

# Attempt to acquire an exclusive lock. Launch the command, capture the PID, and store it in the PIDFILE
(
  flock -n 200

  data=$(replace_data)
  # Split the data text according to period (.)
  echo -e "\e[1;36mdata:\e[0m \"$data\""
  IFS='.' read -ra sentences <<<"$data"
  touch $RUNFILE
  for sentence in "${sentences[@]}"; do
    if [ ! -e "${RUNFILE}" ]; then
      break
    fi
    if echo "$sentence" | grep -Eq "[[:alnum:]]"; then
      echo -e "\e[1;36mText:\e[0m \"$sentence\""
      curl -X POST -H 'Content-Type: text/plain' --output - \
        --data "$sentence." \
        'http://localhost:5002/api/tts' |
        aplay &
      echo $! >"${PIDFILE}"
      # trans :zh-Cn -b "$sentence" | rofi -dmenu -p "Translation"
      wait $!
    fi
  done
) 200>"${PIDFILE}"
