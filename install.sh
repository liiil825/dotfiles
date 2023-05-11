#!/usr/bin/env bash

# set some colors
CNT="[\e[1;36mNOTE\e[0m]"
COK="[\e[1;32mOK\e[0m]"
CER="[\e[1;31mERROR\e[0m]"
CAT="[\e[1;33mATTENTION\e[0m]"
CWR="[\e[1;35mWARNING\e[0m]"
CAC="[\e[1;33mACTION\e[0m]"
INSTLOG="install.log"

# clear the screen
clear

MYCONFIG=$HOME/.config
TMUX_PLUGIN_DIR=$MYCONFIG/tmux/plugins
GITHUB_REPOS=$HOME/Github

echo -e "$CNT - You are about to execute a script that would attempt to setup zsh env."

mkdir -p $MYCONFIG
ln -sf "$(pwd)/config/zsh" $HOME/.config
ln -sf "$(pwd)/config/zsh/zprofile.symlink" $HOME/.zprofile
ln -sf "$(pwd)/config/zsh/zshenv.symlink" $HOME/.zshenv
ln -sf "$(pwd)/config/zsh/zshrc.symlink" $HOME/.zshrc

### set symlink all of the above pacakges ####
read -n1 -rep $'[\e[1;33mACTION\e[0m] - Would you like to set soft link to .config (\e[1;36mtmux bin alacritty kitty lazygit ripgrep keyd waybar\e[0m]) (y,n) ' INST
if [[ $INST == "Y" || $INST == "y" ]]; then
  for SOFTWR in tmux bin alacritty kitty lazygit ripgrep keyd waybar; do
    ln -sf "$(pwd)/config/$SOFTWR" $HOME/.config
  done
fi

if [[ ! -d "$TMUX_PLUGIN_DIR/tpm" ]]; then
  echo -e "$CAT Download tmux plugin manager..."
  mkdir -p $TMUX_PLUGIN_DIR
  git clone --depth 1 https://github.com/tmux-plugins/tpm.git $TMUX_PLUGIN_DIR/tpm &>>$INSTLOG
fi

if ! command -v starship >/dev/null 2>&1; then
  echo -e "$CAT install starship..."
  curl -sS https://starship.rs/install.sh | sh &>>$INSTLOG
fi

if ! command -v zoxide >/dev/null 2>&1; then
  echo -e "$CAT install zoxid..."
  if [[ $(uname) == "Linux" ]]; then
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
  elif [[ $(uname) == "Darwin" ]]; then
    brew install zoxide
  fi
fi

if ! command -v fzf >/dev/null 2>&1; then
  echo -e "$CAT install fzf..."
  git clone --depth 1 https://github.com/junegunn/fzf.git $GITHUB_REPOS/fzf &>>$INSTLOG
  $GITHUB_REPOS/fzf/install
fi
