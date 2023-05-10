#!/usr/bin/env zsh

export BW_RAW=true
export BW_PRETTY=true
set_bw_session() {
    export BW_SESSION=$1
}

get_openai_key() {
    local name="$1"
    [[ -z "$name" ]] && name="nvim"

    bw list items --search OPENAI_API_KEY --folderid "8831d1f8-83a7-485a-82fe-b8b77dc4e2e9" | grep -E "\"name\": \"$name\"|^\s*\"value\":" | awk "/\"name\": \"$name\"/ {getline; print}" | sed 's/.*"value": "\(.*\)",.*/\1/'
}
