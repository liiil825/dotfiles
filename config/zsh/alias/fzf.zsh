if [[ $(uname -n) == "archlinux" ]]; then
  source /usr/share/fzf/key-bindings.zsh
elif [[ $(uname -n) == *"-opencloudos" ]]; then
fi

export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'

# export FZF_DEFAULT_OPTS="\
# --layout=reverse
# --reverse --no-info --prompt=' ' --pointer='' --marker=' ' \
# --color=bg+:,bg:,spinner:#f5e0dc,hl:#f38ba8 \
# --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
# --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# export FZF_TMUX_OPTS="-p \
# --layout=reverse
# --reverse --no-info --prompt=' ' --pointer='' --marker=' ' \
# --color=bg+:,bg:,spinner:#f5e0dc,hl:#f38ba8 \
# --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
# --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^R' fzf-history-widget-accept

export FZF_CTRL_R_OPTS="--reverse"
export FZF_TMUX_OPTS="-p"

alias f='cd $(fd . ~ -t d | fzf)'
alias fc='cd $(fd . ~/.config -t d | fzf)'
eval "$(zoxide init zsh)"
