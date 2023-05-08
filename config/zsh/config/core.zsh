#!/usr/bin/env zsh

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$HOME/.zsh_history

show_path() {
    echo $PATH | tr ':' '\n'
}
zle -N show_path

smart-tmux-seesion() {
  BUFFER="t"
  zle accept-line
}
zle     -N    smart-tmux-seesion
bindkey '^[f' smart-tmux-seesion

# bat
export BAT_THEME='OneHalfDark'

# man-pages
export MANPAGER='sh -c "col -bx | bat -pl man --theme=Monokai\ Extended"'
