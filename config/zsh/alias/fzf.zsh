if [[ $(uname -n) == "archlinux" ]]; then
  source /usr/share/fzf/key-bindings.zsh
  export FZF_TMUX_OPTS="-p"
elif [[ $(uname -n) == *"-opencloudos" ]]; then
fi

export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'

fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^R' fzf-history-widget-accept

export FZF_CTRL_R_OPTS="--reverse"

alias f='cd $(fd . ~ -t d | fzf)'
alias fc='cd $(fd . ~/.config -t d | fzf)'
eval "$(zoxide init zsh)"
