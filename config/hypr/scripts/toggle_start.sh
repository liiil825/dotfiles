#!/bin/bash

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
  rm $LOCKFILE
  case "$1" in
  emacs | emacsclient)
    echo "Emacs is running, killing it now."
    sleep 0.1
    emacsclient -s doom -e "(progn (save-some-buffers t) (delete-frame))"
    ;;
  *)
    echo "$1 is running, killing it now."
    pkill -x "$1"
    ;;
  esac
else
  # if it doesn't exist, create it and start the process
  echo "Creating lockfile."
  touch $LOCKFILE
  case "$1" in
  alacritty | kitty)
    echo "$1 is not running, starting it now."
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
    sleep 0.1
    emacsclient -c -s doom ~/org/todo.org
    ;;
  *)
    echo "$1 is not running, starting it now."
    $1
    ;;
  esac
fi
