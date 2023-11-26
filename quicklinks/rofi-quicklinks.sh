#!/usr/bin/env bash

declare -A QUICKLINKS
QUICKLINKS=(
  [" Reddit"]="https://www.reddit.com/"
  [" Youtube"]="https://www.youtube.com/"
  [" Gitlab"]="https://gitlab.com/"
  [" Steam"]="https://store.steampowered.com/"
)
ORDER=()
PROMPT="Quicklinks"
MESG="Open a link"
CONFIG_PATH="$HOME/.config/rofi/rofi-quicklinks.conf"
THEME_PATH="$HOME/.config/rofi/rofi-quicklinks.rasi"

initialize() {
  if [ -f "$CONFIG_PATH" ]; then
    source "$CONFIG_PATH"
  fi
}

rofi_cmd() {
  if [ -f "$THEME_PATH" ]; then
    rofi -dmenu \
      -p "$PROMPT" \
      -mesg "$MESG" \
      -theme "$THEME_PATH"
  else
    rofi -dmenu \
      -p "$PROMPT" \
      -mesg "$MESG"
  fi
}

options() {
  local accumulator=""
  local keys=()
  if [ -z "$ORDER" ]; then
    keys=("${!QUICKLINKS[@]}")
  else
    keys=("${ORDER[@]}")
  fi

  for key in "${keys[@]}"; do
    accumulator="$accumulator\n$key"
  done
  accumulator="${accumulator}Exit"
  echo -e "$accumulator" | rofi_cmd
}

run_cmd() {
  local option="$1"
  if [ "$option" = "" ] || [ "$option" = "Exit" ]; then
    exit 0
  fi

  xdg-open ${QUICKLINKS["${option}"]}
}

initialize
chosen="$(options)"
run_cmd "$chosen"

