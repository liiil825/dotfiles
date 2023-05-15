#!/usr/bin/env zsh

export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:$HOME/.config/bin/
export PATH=$PATH:$HOME/.local/bin/
export PATH=$PATH:$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin

local detail_os=$(detect-os -r)
[[ $detail_os == "opencloudos" ]] && return

[[ $detail_os == "linux"  ]] && source $ZSH_CUSTOM/path-linux.zsh
[[ $detail_os == "macos" ]] && source $ZSH_CUSTOM/path-macos.zsh
