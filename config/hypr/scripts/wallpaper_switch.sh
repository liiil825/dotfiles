#!/bin/zsh

background=$(find $HOME/Pictures/Wallpaper -type f | shuf -n 1)
swaybg --image $background -m fill &

function close_apps {
LOCKFILE="/tmp/alacritty.lock"
if [ -e $LOCKFILE ]; then
  echo "close alacritty"
  rm $LOCKFILE
  pkill -x alacritty
fi
LOCKFILE="/tmp/emacsclient.lock"
if [ -e $LOCKFILE ]; then
  echo "close emacsclient"
  rm $LOCKFILE
  emacsclient -s doom -e "(progn (save-buffers-kill-terminal))"
fi
}

function handle {
  if [[ ${1:0:9} == "workspace" ]]; then
    echo $line
    newbackground=$(find $HOME/Pictures/Wallpaper -type f | shuf -n 1)
    echo $newbackground
    until [[ ("${background}" != "${newbackground}") && (-r $newbackground) ]]; do
      newbackground=$(find $HOME/Pictures/Wallpaper -type f | shuf -n 1)
      echo $newbackground
      sleep .3
    done
    echo $newbackground
    background=newbackground
    swpid=$(ps axf | grep swaybg | grep -v grep | awk '{printf $1}')
    swaybg --image $newbackground -m fill &
    sleep .3
    kill $swpid
    close_apps
  fi
}

socat - UNIX-CONNECT:/tmp/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock | while read line; do handle $line; done
