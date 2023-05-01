#!/usr/bin/env zsh

hash -d zplugs=$ZSH_CUSTOM/plugins

[[ -d ~zplugs/zgenom ]] || git clone depth 1 https://github.com/jandamm/zgenom ~zplugs/zgenom

source ~zplugs/zgenom/zgenom.zsh

set -o emacs
zgenom autoupdate  # every 7 days
if ! zgenom saved; then
    echo "Creating a zgenom save"

    zgenom ohmyzsh lib/completion.zsh
    zgenom ohmyzsh lib/clipboard.zsh

    zgenom ohmyzsh plugins/sudo
    zgenom ohmyzsh plugins/extract
    zgenom load --completion spwhitt/nix-zsh-completions
    zgenom ohmyzsh --completion plugins/docker-compose
    zgenom load zsh-users/zsh-completions

    zgenom load Aloxaf/fzf-tab
    zgenom load chisui/zsh-nix-shell
    zgenom load zdharma-continuum/fast-syntax-highlighting
    zgenom load zsh-users/zsh-autosuggestions
    # zgenom load zsh-users/zsh-history-substring-search
    # zgenom load hlissner/zsh-autopair
    zgenom load romkatv/zsh-defer

    zgenom clean
    zgenom save
    zgenom compile ~zplugs
fi

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

eval "$(zoxide init zsh)"
if [[ -s "$HOME/.local/share/marker/marker.sh" ]]; then
    source "$HOME/.local/share/marker/marker.sh"
else
    git clone --depth 1 https://github.com/pindexis/marker.git $HOME/.config/.marker
    cd $HOME/.config/.marker && ./install.py
    cd -
fi
