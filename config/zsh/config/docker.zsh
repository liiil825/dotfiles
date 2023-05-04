#!/usr/bin/env zsh

function select_container() {
    docker ps -a | sed 1d | awk '{print $1,$NF,$2,$3,$4,$5,$6}' | column -t | fzf -1 -q "$1" | awk '{print $1}'
}

function da() {
    local cid
    cid=$(select_container "$1")
    [ -n "$cid" ] && docker exit -it "$cid" /bin/sh
}

function dlf() {
    local cid
    cid=$(select_container "$1")
    [ -n "$cid" ] && docker logs -f -n 50 "$cid"
}

function ds() {
    local cid
    cid=$(select_container "$1")
    [ -n "$cid" ] && docker stop "$cid"
}

function drm() {
    local cid
    cid=$(select_container "$1")
    [ -n "$cid" ] && docker rm "$cid"
}

function drm_all() {
    local cid
    cid=$(select_container "$1")
    [ -n "$cid" ] && docker rm $cid
}

function drmi() {
    docker images | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $3 }' | xargs -r docker rmi
}
