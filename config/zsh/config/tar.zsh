#!/usr/bin/env bash

# Terminal colors
TC='\e['
Rst="${TC}0m"
Blk="${TC}30m";
Red="${TC}31m";
Grn="${TC}32m";
Yel="${TC}33m";
Blu="${TC}34m";
Prp="${TC}35m";
Cyn="${TC}36m";
Wht="${TC}37m";

targz_error_msg() {
    echo -e "  ${Red}[ERROR]${Rst} please give me a name"
}


targz() {
    local filename = "{$1:-}"
    [[ $filenam ]] && targz_error_msg && return
    tar xzf $1
}
