#! /usr/bin/env zsh

if [[ $(uname -n) == *"-opencloudos" ]]; then
  return
fi

export DISABLE_IPV6=0

ipv6_toggle_disable () {
  if [[ $(uname) == "Linux" ]]; then
    linux_ipv6_toggle_disable
  elif [[ $(uname) == "Darwin" ]]; then
    macos_ipv6_toggle_disable
  fi
}
linux_ipv6_toggle_disable () {
  if [[ $(uname) != "Linux" ]]; then
    return
  fi

  if [[ $DISABLE_IPV6 == 0 ]]; then
    sudo sed -i 's/net\.ipv6\.conf\.all\.disable_ipv6\ =\ 0/net.ipv6.conf.all.disable_ipv6 = 1/g' /etc/sysctl.conf
    export DISABLE_IPV6=1
  else
    sudo sed -i 's/net\.ipv6\.conf\.all\.disable_ipv6\ =\ 1/net.ipv6.conf.all.disable_ipv6 = 0/g' /etc/sysctl.conf
    export DISABLE_IPV6=0
  fi
  sudo sysctl -p
  sudo systemctl restart NetworkManager.service
}

macos_ipv6_toggle_disable () {
  if [[ $(uname) != "Darwin" ]]; then
    return
  fi

  if [[ $DISABLE_IPV6 == 0 ]]; then
    networksetup -setv6off Wi-Fi
    export DISABLE_IPV6=1
  else
    networksetup -setv6automatic Wi-Fi
    export DISABLE_IPV6=0
  fi
}
