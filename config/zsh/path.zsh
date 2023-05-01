if [[ "$(uname)" == "Linux" ]]; then
    source $ZSH_CUSTOM/path-linux.zsh
fi
if [[ "$(uname)" == "Darwin" ]]; then
    source $ZSH_CUSTOM/path-macos.zsh
fi
