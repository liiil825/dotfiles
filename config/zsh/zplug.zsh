#!/usr/bin/env zsh

if [[ $(uname) == "Darwin" ]]; then
    export ZPLUG_HOME=/usr/local/opt/zplug
elif [[ $(uname) == "Linux" ]]; then
    export ZPLUG_HOME=~/.config/zplug
    # Check if zplug is installed
    if [[ ! -d $ZPLUG_HOME ]]; then
        git clone --depth 1 https://github.com/zplug/zplug $ZPLUG_HOME
    fi
fi
source $ZPLUG_HOME/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

zplug 'zsh-users/zsh-autosuggestions', defer:2
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
zplug 'romkatv/zsh-defer', use:'zsh-defer.plugin.zsh'
zplug 'Aloxaf/fzf-tab', use:'fzf-tab.plugin.zsh'
zplug load

if [[ $(uname -n) == *"-opencloudos" ]]; then
    return
fi

# fzf-tab
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' fzf-bindings 'tab:accept'
# zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:3:wrap'
zstyle ':fzf-tab:complete:kill:*' popup-pad 0 3

zsh-defer eval "$(zoxide init zsh)"
if [[ -s "$HOME/.local/share/marker/marker.sh" ]]; then
    zsh-defer source "$HOME/.local/share/marker/marker.sh"
else
    git clone --depth 1 https://github.com/pindexis/marker.git $HOME/.config/.marker
    cd $HOME/.config/.marker && ./install.py
    cd -
fi
