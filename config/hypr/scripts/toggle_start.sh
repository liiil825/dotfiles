#!/usr/bin/env bash

# check if the script is called with an argument
if [ -z "$1" ]; then
  echo "Please provide a process name as an argument."
  exit 1
fi

LOCKFILE="/tmp/$1.lock"

# check if the lockfile exists
if [ -e $LOCKFILE ]; then
  # if it exists, delete it and kill the process
  echo "Lockfile exists, deleting it now."
  rm "$LOCKFILE"
  case "$1" in
  emacs | emacsclient)
    echo "Emacs is running, killing it now."
    # emacsclient -s doom -e "(progn (save-some-buffers) (delete-frame))"
    emacsclient -s doom -e "(save-buffers-kill-terminal)"
    ;;
  wf-recorder)
    # read -r pid <"${LOCKFILE}"
    kill -SIGUSR2 wf-recorder
    ;;
  mofa)
    pkill -x alacritty
    ;;
  *)
    echo "$1 is running, killing it now."
    pkill -x $1
    ;;
  esac
  exit 0
fi

# Attempt to acquire an exclusive lock. Launch the command, capture the PID, and store it in the PIDFILE
(
  flock -n 200
  case "$1" in
  alacritty | kitty)
    echo "$1 is not running, starting it now."
    # $1 -e zsh -ic "
    if tmux list-sessions &>/dev/null; then
      $1 -e sh -c "tmux attach-session;"
    else
      $1 -e zsh -ic "
        cd ~/Repos/dotfiles;
        tmux new -s dotfiles;
        "
    fi
    ;;
  mofa)
    file=$2
    if [[ -z $file ]]; then
      file="fzf-root"
    else
      file="_$file"
    fi
    alacritty -e sh -ic "$HOME/Repos/dotfiles/config/hypr/scripts/mofa/$file"
    ;;
  emacs | emacsclient)
    echo "$1 is not running, starting it now."
    emacsclient -c -s doom ~/org/todo.org
    ;;
  wf-recorder)
    wf-recorder -g "$(slurp)" -f "$HOME/Downloads/recorder.mp4" &
    echo $! >"${LOCKFILE}"
    ;;
  *)
    echo "$1 is not running, starting it now."
    $1
    ;;
  esac
) 200>"${LOCKFILE}"
