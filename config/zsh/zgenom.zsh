#!/usr/bin/env zsh

hash -d zplugs=$ZSH_CUSTOM/plugins
mkdir -p ~zplugs

[[ -d ~zplugs/zgenom ]] || git clone --depth 1 https://github.com/jandamm/zgenom ~zplugs/zgenom

source ~zplugs/zgenom/zgenom.zsh

zgenom autoupdate  # every 7 days
if ! zgenom saved; then
    echo "Creating a zgenom save"

    zgenom ohmyzsh lib/completion.zsh
    zgenom ohmyzsh lib/clipboard.zsh

    zgenom ohmyzsh plugins/sudo
    zgenom ohmyzsh plugins/extract
    zgenom ohmyzsh --completion plugins/docker-compose
    zgenom load zsh-users/zsh-completions

    zgenom load Aloxaf/fzf-tab
    zgenom load zdharma-continuum/fast-syntax-highlighting
    zgenom load zsh-users/zsh-autosuggestions
    zgenom load romkatv/zsh-defer

    zgenom clean
    zgenom save
    zgenom compile ~zplugs
fi

eval "$(zoxide init zsh)"
[[ $(uname -n) == *"-opencloudos" ]] && return

# MARKER_KEY_GET="\C-f"  # trigger key, default by C-Space
# MARKER_KEY_MARK="\C-"  # default C-m
# MARKER_KEY_NEXT_PLACEHOLDER="\C-"  # default C-t
if [[ -s "$HOME/.local/share/marker/marker.sh" ]]; then
    source "$HOME/.local/share/marker/marker.sh"
else
    git clone --depth 1 https://github.com/pindexis/marker.git $HOME/.config/.marker
    $HOME/.config/.marker/install.py
fi
