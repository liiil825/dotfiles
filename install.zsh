#!/usr/bin/env zsh

hash -d config=$HOME/.config
hash -d tplugs=~config/tmux/plugins
hash -d repos=$HOME/repos

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

if ! command -v starship >/dev/null 2>&1; then
    echo -e "\033[36;1;4m install starship...\033[0m"
    curl -sS https://starship.rs/install.sh | sh
fi

if ! command -v zoxide >/dev/null 2>&1; then
    echo -e "\033[36;1;4m install zoxid...\033[0m"
    if [[ $(uname) == "Linux" ]]; then
        curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    elif [[ $(uname) == "Darwin" ]]; then
        brew install zoxide
    fi
fi

if ! command -v fzf >/dev/null 2>&1; then
    echo -e "\033[36;1;4m install fzf...\033[0m"
    git clone --depth 1 https://github.com/junegunn/fzf.git ~repos/fzf
    ~repos/fzf/install
fi
