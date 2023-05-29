#!/usr/bin/env bash

select_img() {
  wallpaper_dir="$HOME/Pictures/Wallpaper"
  echo $(fd . --full-path $wallpaper_dir --type f | shuf -n 1)
}

random_img() {
  # Get the list of file addresses in the swapbg directory
  existing_imgs=()
  for file in "$swaybg_dir/*.lock"; do
    existing_imgs+=("$(cat $file)")
  done

  # Get a random file address from the wallpaper directory that is not in the swapbg directory
  selected_address=""
  while [[ -z $selected_address ]]; do
    img=$(select_img)
    if ! [[ "${existing_imgs[@]}" =~ "$img" ]]; then
      selected_address=$img
    fi
  done

  # Print the selected file address
  echo $selected_address
}
close_apps() {
  local LOCKFILE="/tmp/alacritty.lock"
  if [ -e $LOCKFILE ]; then
    echo "close alacritty"
    rm $LOCKFILE
    pkill -x alacritty
  fi
  local LOCKFILE="/tmp/emacsclient.lock"
  if [ -e $LOCKFILE ]; then
    echo "close emacsclient"
    rm $LOCKFILE
    emacsclient -s doom -e "(progn (save-buffers-kill-terminal))"
  fi
}

handle() {
  if [[ ${1:0:9} == "workspace" ]]; then
    close_apps
    workspace=$(echo $line | awk -F\>\> '{print $2}')
    echo "workspace = $workspace"
    if [[ -e "$swaybg_dir/$workspace.lock" ]]; then
      read -r newbackground <"/tmp/swaybg/$workspace.lock"
    else
      newbackground=$(random_img)
      echo $newbackground >"/tmp/swaybg/${workspace}.lock"
    fi
    read -r swpid <"${PIDFILE}"
    swaybg --image $newbackground -m fill &
    echo $! >"${PIDFILE}"
    sleep 1
    kill $swpid
  fi
}

swaybg_dir="/tmp/swaybg"
rm -rf $swaybg_dir
mkdir -p $swaybg_dir
PIDFILE="/tmp/swaybg.lock"
background=$(select_img)
swaybg --image $background -m fill &
echo $! >"${PIDFILE}"
echo $background >/tmp/swaybg/1.lock
socat - UNIX-CONNECT:/tmp/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock | while read line; do handle $line; done
