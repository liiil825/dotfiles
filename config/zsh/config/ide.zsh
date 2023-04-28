#! /usr/bin/env zsh
if [[ $(uname -n) == *"-opencloudos" ]]; then
  TERM="xterm-256color"
  return
fi

if [[ $(uname) == "Linux" ]]; then
  # linux 下设置错误的 TERM
  # 会在命令行执行后，下一行会多显示一次
  # 修复 archlinux 下的 tmux 256-color 显示错误
  if [[ $TERM != "tmux-256color" ]]; then
    alias tmux="TERM=tmux-256color tmux -2" 
  fi
elif [[ $(uname) == "Darwin" ]]; then
  TERM="screen-256color"
fi

alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias vf='vim $(fd . -t d | fzf --height=40% --layout=reverse)'

export VISUAL=nvim
export EDITOR=$VISUAL

alias nvim-astro="NVIM_APPNAME=nvim-astro nvim"
alias nvim-lazy="NVIM_APPNAME=nvim-lazy nvim"
alias nvim-chad="NVIM_APPNAME=nvim-nvchad nvim"
alias nvim-lunar="NVIM_APPNAME=nvim-lunar nvim"

function nvims() {
  itemNames=("default" "LazyVim" "NvChad" "AstroNvim" "LunarNvim")
  itemAlias=("default" "nvim-lazy" "nvim-nvchad" "nvim-astro" "nvim-lunar")
  config=$(printf "%s\n" "${itemNames[@]}" | fzf --prompt=" Neovim Config  " --height=50% --layout=reverse --border --exit-0)

  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    echo "Selected default config"
    config=""
  else
    for ((i=0;i < $#itemAlias; i+=1)); do
      if [[ "${itemNames[$i]}" == "$config" ]]; then
        config="${itemAlias[$i]}"
        break
      fi
    done
  fi

  echo $config

  NVIM_APPNAME=$config nvim $@
}

function nvim_change() {
  alias nvim="NVIM_APPNAME=nvim-$1 nvim"
}

function nvim_clean() {
  unalias nvim
}
