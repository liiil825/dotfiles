#!/usr/bin/env zsh

local dir=$(pwd)
mkdir -p $HOME/.config
ln -sf $dir/config/zsh $HOME/.config
ln -sf $dir/config/zsh/zprofile.symlink $HOME/.zprofile
ln -sf $dir/config/zsh/zshenv.symlink $HOME/.zshenv
ln -sf $dir/config/zsh/zshrc.symlink $HOME/.zshrc

ln -sf $dir/config/tmux $HOME/.config
