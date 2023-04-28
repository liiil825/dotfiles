#! /usr/bin/env zsh
if [[ $(uname -n) == *"-opencloudos" ]]; then
  return
fi
if [[ "$(uname)" == "Darwin" ]]; then
  return
fi
export PATH=$PATH:$HOME/.config/bin/

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
