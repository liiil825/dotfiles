[[ $(uname -n) == *"-opencloudos" ]] && return

export PROXYHOST=localhost
export PROXYPORT=1086
# export all_proxy=socks5://$PROXYHOST:$PROXYPORT

show_proxy () {
    echo all_proxy: $all_proxy
    echo http_proxy: $http_proxy
    echo https_proxy: $https_proxy
}

set_proxy () {
    [[ $1 ]] && export PROXYPORT=$1
    [[ $2 ]] && export PROXYHOST=$2
    if [[ $3 ]]; then
        export http_proxy=http://$PROXYHOST:$PROXYPORT
        export https_proxy=https://$PROXYHOST:$PROXYPORT
    else
        export all_proxy=socks5://$PROXYHOST:$PROXYPORT
    fi
}
unset_proxy () {
    unset http_proxy
    unset https_proxy
    unset all_proxy
}

mylocalip () {
    mylocalip="$(ifconfig | grep 'inet.*netmask.*broadcast')"
    lanip="$(echo $myip | awk '{print $2}')"
    publicip="$(echo $myip | awk '{print $6}')"
    echo '你的局域网IP是: '$lanip
    echo '你的外网IP是: '$publicip
    echo '你的局域网IP是' $lanip | pbcopy
}
zle -N mylocalip

alias myip='curl http://wtfismyip.com/json'
