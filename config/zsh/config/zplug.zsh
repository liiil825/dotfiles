#! /usr/bin/env zsh
if [[ $(uname -n) == *"-opencloudos" ]]; then
  return
fi

if [[ $(uname) == "Darwin" ]]; then
  export ZPLUG_HOME=/usr/local/opt/zplug
elif [[ $(uname) == "Linux" ]]; then
  export ZPLUG_HOME=~/.config/zplug
  # Check if zplug is installed
  if [[ ! -d ~/.config/zplug ]]; then
    git clone --depth 1 https://github.com/zplug/zplug $ZPLUG_HOME
  fi
fi
source $ZPLUG_HOME/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
# # Bind CTRL+k and CTRL+j to substring search
bindkey '\ek' history-substring-search-up
bindkey '\ej' history-substring-search-down

zplug "joshskidmore/zsh-fzf-history-search"
export ZSH_FZF_HISTORY_SEARCH_BIND="^r"
export ZSH_FZF_HISTORY_SEARCH_FZF_EXTRA_ARGS="--height=60% --layout=reverse"

zplug "changyuheng/fz", defer:1
zplug "rupa/z", use:z.sh

zplug load
