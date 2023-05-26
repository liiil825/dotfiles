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
    # emacsclient -s doom -e "(progn (save-buffers-kill-terminal))"
    emacsclient -s doom -e "(save-buffers-kill-terminal)"
    ;;
  *)
    echo "$1 is running, killing it now."
    pkill -x "$1"
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
    # $1 -e sh -c "
    $1 -e zsh -ic "
       if tmux list-sessions &> /dev/null; then
         tmux attach-session;
       else
         cd ~/Repos/dotfiles;
         tmux new -s dotfiles;
       fi"
    ;;
  emacs | emacsclient)
    echo "$1 is not running, starting it now."
    emacsclient -c -s doom ~/org/todo.org
    ;;
  *)
    echo "$1 is not running, starting it now."
    $1
    ;;
  esac

) 200>"${LOCKFILE}"
