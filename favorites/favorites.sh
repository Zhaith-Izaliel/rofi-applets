#!/usr/bin/env bash

declare -A APPS
APPS=(
  [" Kitty"]="kitty"
  [" Nemo"]="nemo"
  [" Firefox"]="Firefox"
  [" Cfiles"]="kitty -e cfiles"
  [" Neovim"]="kitty -e nvim"
  [" NCMPCPP"]="kitty -e ncmpcpp"
)
PROMPT="Applications"
MESG="Run Applications as Root"
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
  for key in "${!APPS[@]}"; do
    accumulator="$accumulator$key\n"
  done
  echo -e "$accumulator" | rofi_cmd
}

run_cmd() {
  local option="$1"
  if [ "$option" = "" ]; then
    exit 0
  fi

  ${APPS["${option}"]}
}

chosen="$(options)"
run_cmd "$chosen"

