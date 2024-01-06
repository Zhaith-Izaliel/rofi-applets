#!/usr/bin/env bash

declare -A QUICKLINKS
QUICKLINKS=()
ORDER=()
EXIT_TEXT="Exit"
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
    if [ "$accumulator" = "" ]; then
      accumulator="$key"
      continue
    fi
    accumulator="$accumulator\n$key"
  done
  accumulator="${accumulator}\n${EXIT_TEXT}"
  echo -e "$accumulator" | rofi_cmd
}

run_cmd() {
  local option="$1"
  if [ "$option" = "" ] || [ "$option" = "$EXIT_TEXT" ]; then
    exit 0
  elif [ ${QUICKLINKS["${option}"]} = "" ]; then
    echo "You picked an incorrect option. Did you configure your order correctly?"
    exit 1
  fi

  xdg-open ${QUICKLINKS["${option}"]}
}

initialize
chosen="$(options)"
run_cmd "$chosen"

