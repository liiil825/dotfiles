#!/usr/bin/env zsh

[[ "$(uname)" == "Darwin" ]] && return

# go environment
export GO111MODULE=on
export GOPROXY=https://goproxy.cn,direct
export GOPATH=$HOME/code/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# python path
export PATH=$PATH:$HOME/.local/lib/python3.10/site-packages

# rust
export PATH=$PATH:$HOME/.cargo/bin/
