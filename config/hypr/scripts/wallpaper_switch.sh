#!/usr/bin/env bash

select_img() {
  wallpaper_dir="$HOME/Pictures/Wallpaper"
  echo $(fd . --full-path $wallpaper_dir --type f | shuf -n 1)
}

random_img() {
  # Get the list of file addresses in the swapbg directory
  existing_imgs=()
  for file in "$SWAYBG_DIR/*.lock"; do
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
    workspace=$(echo $1 | awk -F\>\> '{print $2}')
    newbackground=""
    if [[ -e "$SWAYBG_DIR/$workspace.lock" ]]; then
      read -r newbackground <"$SWAYBG_DIR/$workspace.lock"
    else
      newbackground=$(random_img)
      echo $newbackground >"${SWAYBG_DIR}/${workspace}.lock"
    fi
    read -r pid <"${PIDFILE}"
    swww img $newbackground --transition-fps 60 --transition-type wipe --transition-bezier ".42,0,.58,1" --transition-duration 1 &
    echo $! >"${PIDFILE}"
    close_apps
  fi
}

SWAYBG_DIR="/tmp/swaybg"
rm -rf $SWAYBG_DIR
mkdir -p $SWAYBG_DIR
PIDFILE="/tmp/swaybg.lock"
black_img="$HOME/Pictures/black.png"
background=$(select_img)
swww init
sleep 0.1
swww img $newbackground --transition-fps 60 --transition-type wipe --transition-bezier ".42,0,.58,1" --transition-duration 1 &
echo $! >"${PIDFILE}"
echo $background >"${SWAYBG_DIR}/1.lock"
socat - UNIX-CONNECT:/tmp/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock | while read line; do handle $line; done
