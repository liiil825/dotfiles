#!/usr/bin/env sh

parse_type() {
  selected_type=$1
  case "$selected_type" in
  "📙")
    selected_type=0
    ;;
  "🖼️")
    selected_type=1
    ;;
  "📚")
    selected_type=2
    ;;
  "🗞️")
    selected_type=3
    ;;
  *)
    selected_type=0
    ;;
  esac
  echo "$selected_type"
}
