#!/usr/bin/env zsh

export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:$HOME/.config/bin/
export PATH=$PATH:$HOME/.local/bin/

[[ $(uname -n) == *"-opencloudos" ]] && return

export PATH=$PATH:$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin

[[ "$(uname)" == "Linux"  ]] && source $ZSH_CUSTOM/path-linux.zsh
[[ "$(uname)" == "Darwin" ]] && source $ZSH_CUSTOM/path-macos.zsh
