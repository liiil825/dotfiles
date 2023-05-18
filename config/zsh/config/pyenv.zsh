#!/usr/bin/env zsh

[[ $SYSTEM_PLATFORM == "opencloud"* ]] && return

# python pyenv
export PYENV_ROOT=$HOME/.pyenv
command -v pyenv >/dev/null || export PATH=$PATH:$PYENV_ROOT/bin
zsh-defer eval "$(pyenv init -)"
