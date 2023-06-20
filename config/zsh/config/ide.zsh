#!/usr/bin/env zsh

alias nvim-astro="NVIM_APPNAME=nvim-astro nvim"
alias nvim-lazy="NVIM_APPNAME=nvim-lazy nvim"
alias nvim-chad="NVIM_APPNAME=nvim-nvchad nvim"

function nvims() {
    itemNames=("default" "LazyVim" "NvChad" "AstroNvim")
    itemAlias=("default" "nvim-lazy" "nvim-nvchad" "nvim-astro")
    config=$(printf "%s\n" "${itemNames[@]}" | fzf --prompt=" Neovim Config  "\
        --height=50% --layout=reverse --border --exit-0)

    if [[ -z $config ]]; then
        echo "Nothing selected"
        return 0
    elif [[ $config == "default" ]]; then
        echo "Selected default config"
        config=""
    else
        for ((i=0;i < $#itemAlias; i+=1)); do
            if [[ "${itemNames[$i]}" == "$config" ]]; then
                config="${itemAlias[$i]}"
                break
            fi
        done
    fi

    echo $config

    NVIM_APPNAME=$config nvim $@
}

function nvim_change() {
    alias nvim="NVIM_APPNAME=nvim-$1 nvim"
}

function nvim_clean() {
    unalias nvim
}

function nvim_reset() {
    rm -rf ~/.cache/nvim
    rm -rf ~/.local/share/nvim
    rm -rf ~/.local/state/nvim
}
