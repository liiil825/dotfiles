#!/usr/bin/env zsh

export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:$HOME/.config/bin/
export PATH=$PATH:$HOME/.local/bin/
export PATH=$PATH:$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin

export SYSTEM_PLATFORM=$($ZSH_CUSTOM/functions/detect-os -r)
[[ $SYSTEM_PLATFORM == "opencloud"* ]] && return

[[ $SYSTEM_PLATFORM == *"linux"  ]] && source $ZSH_CUSTOM/path-linux.zsh
[[ $SYSTEM_PLATFORM == "macos" ]] && source $ZSH_CUSTOM/path-macos.zsh
