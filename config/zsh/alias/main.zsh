#!/usr/bin/env zsh

alias ra="ranger"

if [[ $(uname) == "Darwin" ]]; then
  return
fi
alias show_tcp_port="sudo ss -tulpn"
