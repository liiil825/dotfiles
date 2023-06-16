#!/usr/bin/env sh

echo -ne "\033]0;fzf-mofa\007"

export FZF_DEFAULT_OPTS="\
--reverse \
--border rounded \
--no-info \
--pointer='' \
--marker=' ' \
--ansi \
--color='16,bg+:-1,gutter:-1,prompt:5,pointer:5,marker:6,border:4,label:4'"

quit() {
  rm -f /tmp/mofa.lock
  hyprctl dispatch killactive
}

hide() {
  echo -ne "\033]0;hide\007"
}
