#!/usr/bin/env zsh

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$HOME/.zsh_history
set -o emacs

show_path() {
    echo $PATH | tr ':' '\n'
}
zle -N show_path

# bat
export BAT_THEME='OneHalfDark'

# man-pages
export MANPAGER='sh -c "col -bx | bat -pl man --theme=Monokai\ Extended"'
