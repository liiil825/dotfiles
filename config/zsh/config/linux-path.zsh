#! /usr/bin/env zsh
if [[ "$(uname)" == "Darwin" ]]; then
  return
fi
export PATH=$PATH:$HOME/.config/bin/

# ~/.config/tmux/plugins
export PATH=$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$PATH

if [[ $(uname -n) == *"-opencloudos" ]]; then
  export PATH=$PATH:$HOME/.local/bin/
  return
fi

# go environment
export GO111MODULE=on
export GOPROXY=https://goproxy.cn,direct
export GOPATH=$HOME/code/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# python path
export PATH=$PATH:$HOME/.local/bin/
export PATH=$PATH:$HOME/.local/lib/python3.10/site-packages

# python pyenv
export PYENV_ROOT=$HOME/.pyenv
command -v pyenv >/dev/null || export PATH=$PATH:$PYENV_ROOT/bin
eval "$(pyenv init -)"

# rust
export PATH=$PATH:$HOME/.cargo/bin/
