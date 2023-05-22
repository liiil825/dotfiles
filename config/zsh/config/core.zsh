#!/usr/bin/env zsh

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$HOME/.zsh_history

smart-tmux-seesion() {
    BUFFER="t"
    zle accept-line
}
zle     -N    smart-tmux-seesion
# bindkey '^[f' smart-tmux-seesion

quick-ls() {
    BUFFER="la"
    zle accept-line
}
zle     -N    quick-ls
bindkey '^[l' quick-ls

# bat
export BAT_THEME='OneHalfDark'

# man-pages
export MANPAGER='sh -c "col -bx | bat -pl man --theme=Monokai\ Extended"'
