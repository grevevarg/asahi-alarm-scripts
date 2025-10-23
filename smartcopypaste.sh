#!/bin/bash

action=$1
term_class=$2
active_window="$(hyprctl activewindow -j | jq -r '.class')"

case "$action" in
  copy)
    key='C'
    ;;
  paste)
    key='V'
    ;;
  cut)
    key='X'
    ;;
  *)
  echo "$action not recognized, perhaps a typo?" >&2
  exit 1
  ;;
esac

if [[ $active_window == *"$term_class"* ]]; then
  shortcut="CTRL_SHIFT,$key,"
else
  shortcut="CTRL,$key,"
fi

hyprctl dispatch sendshortcut "$shortcut"
