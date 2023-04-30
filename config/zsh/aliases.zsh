alias ra="ranger"

alias p='pnpm'
alias pi='pnpm i'
alias pid='pnpm i --save-dev'
alias pis='pnpm i --save'

alias v="nvim"
alias vi="nvim"
alias vim="nvim"

alias vf='vim $(fd . -t d | fzf --height=40% --layout=reverse)'
alias vn='cd ~/.config/nvim/lua/user && vim'
alias vt='cd ~/.config/tmux && vim tmux.conf'
alias vz='cd ~/.config/zsh && vim'

alias gcls='git clone --depth 1 '
alias cbr='git branch --sort=-committerdate | fzf --header "Checkout Recent Branch" --preview "git diff {1} --color=always" --pointer="" | xargs git checkout'

alias show_tucp_port="sudo ss -tulpn"
