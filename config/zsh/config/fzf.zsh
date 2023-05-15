[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_DEFAULT_OPTS="\
--reverse \
--border rounded \
--no-info \
--pointer='' \
--marker=' ' \
--ansi \
--color='16,bg+:-1,gutter:-1,prompt:5,pointer:5,marker:6,border:4,label:4'"
export FZF_TMUX_OPTIONS="$FZF_DEFAULT_OPTS"

export FZF_CTRL_R_OPTS="--border-label=' history ' \
--prompt='  '"

# Using highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)
export FZF_CTRL_T_OPTS="
--preview 'bat -n --color=always {}'
--bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

fzf-history-widget-accept() {
    fzf-history-widget
    zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^R'   fzf-history-widget-accept

fzf-man-widget() {
    batman="MANWIDTH=160 man {1} | col -bx | bat --language=man --plain --color always --theme=\"Monokai Extended\""
    man -k . | sort \
        | awk -v cyan=$(tput setaf 6) -v blue=$(tput setaf 4) -v res=$(tput sgr0) -v bld=$(tput bold) '{ $1=cyan bld $1; $2=res blue;} 1' \
        | fzf  \
        -q "$1" \
        --ansi \
        --tiebreak=begin \
        --prompt=' Man > '  \
        --preview-window '50%,rounded,<50(up,85%,border-bottom)' \
        --preview "${batman}" \
        --bind "enter:execute(man {1})" \
        --bind "alt-c:+change-preview(cht.sh {1})+change-prompt(ﯽ Cheat > )" \
        --bind "alt-m:+change-preview(${batman})+change-prompt( Man > )" \
        --bind "alt-t:+change-preview(tldr --color=always {1})+change-prompt(ﳁ TLDR > )"
    zle reset-prompt
}

# `Ctrl-H` keybinding to launch the widget (this widget works only on zsh, don't know how to do it on bash and fish (additionaly pressing`ctrl-backspace` will trigger the widget to be executed too because both share the same keycode)
zle     -N    fzf-man-widget
bindkey '^[h' fzf-man-widget
