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

zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-syntax-highlighting'
zplug 'mafredri/zsh-async', from:'github', use:'async.zsh'

if [[ -s "$HOME/.local/share/marker/marker.sh" ]]; then
    source "$HOME/.local/share/marker/marker.sh"
else
    git clone --depth 1 https://github.com/pindexis/marker.git $HOME/.config/.marker
    cd $HOME/.config/.marker && ./install.py
    cd -
fi

zplug load
eval "$(zoxide init zsh)"
