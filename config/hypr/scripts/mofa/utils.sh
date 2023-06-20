#!/usr/bin/env sh

export FZF_DEFAULT_OPTS="\
--reverse \
--border rounded \
--no-info \
--pointer='' \
--marker=' ' \
--ansi \
--color='16,bg+:-1,gutter:-1,prompt:5,pointer:5,marker:6,border:4,label:4'"

quit() {
  read -r PID <"/tmp/mofa.lock"
  rm -f /tmp/mofa.lock
  kill -9 $PID
}

echo -ne "\033]0;normal-window\007"

# set some colors
CNT="[\e[1;36mNOTE\e[0m]"

hide() {
  echo -ne "\033]0;hide-window\007"
}

make_window_smaller() {
  echo -ne "\033]0;smaller-window\007"
}

make_window_bigger() {
  echo -ne "\033]0;smaller-window\007"
}
