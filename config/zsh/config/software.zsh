#!/usr/bin/env zsh

refresh_yay_txt() {
    yay -Qi $(yay -Qq) \
        | awk '/^Name/{name=$3} /^Description/{sub(/^Description\s*:\s*/, ""); printf "%s # %s\n", name, $0}' \
        | column -t -o ' # ' -s'#' \
        |  sed 's/ *# *$//' > yay.txt
}

refresh_pacman_txt() {
    pacman -Qi \
        | awk -F':' '/^Name/{name=$2} /^Description/{printf "%s #%s\n", name, $2}' \
        | column -t -o ' # ' -s'#' \
        | sed 's/ *# *$//' > yay.txt
}

alias calibre="QT_QPA_PLATFORM=xcb calibre"
alias ebook-viewer="QT_QPA_PLATFORM=xcb ebook-viewer"
