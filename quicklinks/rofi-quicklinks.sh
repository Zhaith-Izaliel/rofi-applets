#!/usr/bin/env bash

declare -A QUICKLINKS
QUICKLINKS=(
  [" Reddit"]="https://www.reddit.com/"
  [" Youtube"]="https://www.youtube.com/"
  [" Gitlab"]="https://gitlab.com/"
  [" Steam"]="https://store.steampowered.com/"
)
PROMPT="Applications"
MESG="Run Applications as Root"
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
  for key in "${!QUICKLINKS[@]}"; do
    accumulator="$accumulator$key\n"
  done
  echo -e "$accumulator" | rofi_cmd
}

run_cmd() {
  local option="$1"
  if [ "$option" = "" ]; then
    exit 0
  fi

  xdg-open ${QUICKLINKS["${option}"]}
}

chosen="$(options)"
run_cmd "$chosen"

