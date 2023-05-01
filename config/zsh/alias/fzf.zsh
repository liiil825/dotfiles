if [[ $(uname -n) == "archlinux" ]]; then
    [ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
    [ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
elif [[ $(uname -n) == *"-opencloudos" ]]; then
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --follow -g "!{.git,node_modules}/*" 2> /dev/null'
# export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_DEFAULT_OPTS='--ansi --height=60% --reverse --cycle --bind=tab:accept'
# export FZF_DEFAULT_OPTS="\
    # --reverse --prompt=' ' --pointer='' --marker=' ' \
    # --color=bg+:,bg:,spinner:#f5e0dc,hl:#f38ba8 \
    # --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    # --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# export FZF_TMUX_OPTS="-p \
    # --reverse --prompt=' ' --pointer='' --marker=' ' \
    # --color=bg+:,bg:,spinner:#f5e0dc,hl:#f38ba8 \
    # --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    # --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# # Using highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)
# export FZF_CTRL_T_OPTS="
# --preview 'bat -n --color=always {}'
# --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
--preview 'echo {}' --preview-window up:3:hidden:wrap
--bind 'ctrl-/:toggle-preview'
--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
--color header:italic
--header 'Press CTRL-Y to copy command into clipboard'"

fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}
zle     -N        fzf-history-widget-accept
bindkey '^X ^R'   fzf-history-widget-accept

alias pacs='pacman --color always -Sl | sed -e "s: :/:; /installed/d" | cut -f 1 -d " " | fzf --multi --ansi --preview "pacman -Si {1}" | xargs -ro sudo pacman -S'
alias pars='paru --color always -Sl | sed -e "s: :/:; s/ unknown-version//; /installed/d" | fzf --multi --ansi --preview "paru -Si {1}" | xargs -ro paru -S'
alias pacr="pacman --color always -Q | cut -f 1 -d ' ' | fzf --multi --ansi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"

alias f='cd $(fd . ~ -t d | fzf)'
alias fc='cd $(fd . ~/.config -t d | fzf)'

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
zle -N fzf-man-widget
bindkey '^[h' fzf-man-widget
# Icon used is nerdfont
