#!/usr/bin/env bash

select_img() {
  wallpaper_dir="$HOME/Pictures/Wallpaper"
  echo $(fd . --full-path $wallpaper_dir --type f | shuf -n 1)
}

random_img() {
  # Get the list of file addresses in the swapbg directory
  existing_imgs=()
  for file in "$BG_DIR/*.lock"; do
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
  local LOCKFILE="/tmp/kitty.lock"
  if [ -e $LOCKFILE ]; then
    echo "close kitty"
    rm $LOCKFILE
    pkill -x kitty
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
    if [[ -e "$BG_DIR/$workspace.lock" ]]; then
      read -r background <"$BG_DIR/$workspace.lock"
    else
      background=$(random_img)
      echo $background >"${BG_DIR}/${workspace}.lock"
    fi
    swww img $background --transition-fps 60 --transition-type wipe --transition-bezier ".88,.06,.29,.94" --transition-duration .8 &
    close_apps
  fi
}

BG_DIR="/tmp/swww"
rm -rf $BG_DIR
mkdir -p $BG_DIR
black_img="$HOME/Pictures/black.png"
background=$(select_img)
swww init
sleep 0.1
swww img $background --transition-fps 60 --transition-type wipe --transition-bezier ".88,.06,.29,.94" --transition-duration .8 &
echo $background >"${BG_DIR}/1.lock"
socat - UNIX-CONNECT:/tmp/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock | while read line; do handle $line; done
