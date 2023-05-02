alias -g ..='cd ..'
alias -g ...='cd ../..'
alias -g ....='cd ../../..'
alias -g .....='cd ../../../..'
alias -g ......='cd ../../../../..'

alias -- -='cd -'
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias gaa='git add --all'
alias gcl='git clone '
alias gst='git status'
alias ggl='git pull --no-edit'
alias ggp='git push'

alias f='cd $(fd . ~ -t d | fzf)'
alias fc='cd $(fd . ~/.config -t d | fzf)'
# alias fvim='vim $(fd . ~/.config -t d | fzf'

alias md='mkdir -p'
alias ra="ranger"
alias rd=rmdir

alias ls='ls --color=always'
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list
alias ldot='ls -ld .*'
alias lS='ls -1FSsh'
alias lart='ls -1Fcart'
alias lrt='ls -1Fcrt'
alias lsr='ls -lARFh' #Recursive list of files and directories
alias lsn='ls -1'     #A column contains name of files and directories

alias pacs='pacman --color always -Sl | sed -e "s: :/:; /installed/d" | cut -f 1 -d " " | fzf --multi --ansi --preview "pacman -Si {1}" | xargs -ro sudo pacman -S'
alias pars='paru --color always -Sl | sed -e "s: :/:; s/ unknown-version//; /installed/d" | fzf --multi --ansi --preview "paru -Si {1}" | xargs -ro paru -S'
alias pacr="pacman --color always -Q | cut -f 1 -d ' ' | fzf --multi --ansi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"

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
alias grep='grep --color'
alias gwl='git worktree list'
alias cbr='git branch --sort=-committerdate | fzf --header "Checkout Recent Branch" --preview "git diff {1} --color=always" --pointer="" | xargs git checkout'

alias show_tucp_port="sudo ss -tulpn"
