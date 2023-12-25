#!/usr/bin/env bash

PROFILES=()
PROMPT="Power Profiles Daemon"
MESG="Current profile: $(powerprofilesctl get)"
CONFIG_PATH="$HOME/.config/rofi/rofi-power-profiles.conf"
THEME_PATH="$HOME/.config/rofi/rofi-power-profiles.rasi"

get_performance() {
  local profiles_list="$(powerprofilesctl list)"
  if [[ "$profiles_list" == *"performance"* ]]; then
    PROFILES+=("performance")
  fi
}

initialize() {
  if [ -z "$CONFIG_PATH" ]; then
    source "$CONFIG_PATH"
  fi
  get_performance
  PROFILES+=(
    "balanced"
    "power-saver"
  )
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
  local keys=("${PROFILES[@]}")

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

  powerprofilesctl set "$option"
}

initialize
chosen="$(options)"
run_cmd "$chosen"

