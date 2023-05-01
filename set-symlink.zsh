#!/usr/bin/env zsh

hash -d config=$HOME/.config
hash -d tplugs=~config/tmux/plugins

local dir=$(pwd)
mkdir -p ~config
ln -sf $dir/config/zsh $HOME/.config
ln -sf $dir/config/zsh/zprofile.symlink $HOME/.zprofile
ln -sf $dir/config/zsh/zshenv.symlink $HOME/.zshenv
ln -sf $dir/config/zsh/zshrc.symlink $HOME/.zshrc

ln -sf $dir/config/tmux $HOME/.config
ln -sf $dir/config/bin $HOME/.config

if [[ ! -d ~tplugs/tpm ]]; then
    echo Download tmux plugin manager
    mkdir -p ~tplugs
    git clone --depth 1 https://github.com/tmux-plugins/tpm.git ~tplugs/tpm
fi
