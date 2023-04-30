HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

show_path() {
    echo $PATH | tr ':' '\n'
}
zle -N show_path
