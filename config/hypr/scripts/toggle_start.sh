#!/bin/bash

# check if the script is called with an argument
if [ -z "$1" ]; then
  echo "Please provide a process name as an argument."
  exit 1
fi

# check if the process is running
# use pgrep to check for emacs instead of emacsclient
if pgrep -x "$1" >/dev/null; then
  # if it is running, kill it
  case "$1" in
  emacs | emacsclient)
    # save all changes and kill emacsclient safely
    echo "Emacs is running, killing it now."
    emacsclient -s doom -e "(progn (save-some-buffers t) (save-buffers-kill-terminal))"
    # emacsclient -s doom -e "(progn (save-some-buffers t) (save-buffers-kill-emacs))"
    # emacsclient -s doom -e "(progn (save-some-buffers t) (make-frame-invisible nil t))"
    ;;
  *)
    echo "$1 is running, killing it now."
    pkill -x "$1"
    ;;
  esac
else
  # if it is not running, start it
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
    emacsclient -c -s doom -a emacs ~/org/todo.org
    ;;
  *)
    echo "$1 is not running, starting it now."
    $1
    ;;
  esac
fi
