#!/usr/bin/env bash

declare -A FAVORITES
FAVORITES=(
  [" Kitty"]="kitty"
  [" Nemo"]="nemo"
  [" Firefox"]="Firefox"
  [" Neovim"]="kitty -e nvim"
  [" NCMPCPP"]="kitty -e ncmpcpp"
)
ORDER=()
PROMPT="Favorties"
MESG="Open an app"
CONFIG_PATH="$HOME/.config/rofi/rofi-favorites.conf"
THEME_PATH="$HOME/.config/rofi/rofi-favorites.rasi"

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
    keys=("${!FAVORITES[@]}")
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
  accumulator="${accumulator}\nExit"
  echo -e "$accumulator" | rofi_cmd
}

run_cmd() {
  local option="$1"
  if [ "$option" = "" ] || [ "$option" = "Exit" ]; then
    exit 0
  fi

  ${FAVORITES["${option}"]}
}

initialize
chosen="$(options)"
run_cmd "$chosen"

