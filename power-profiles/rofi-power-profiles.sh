#!/usr/bin/env bash

declare -A PROFILES
PROFILES=(
  ["$PERFORMANCE_TEXT"]="performance"
  ["$BALANCED_TEXT"]="balanced"
  ["$POWER_SAVER_TEXT"]="power-saver"
)
ORDER=()
PROMPT="Power Profiles Daemon"
PERFORMANCE_TEXT="Performance"
BALANCED_TEXT="Balanced"
POWER_SAVER_TEXT="Power saver"
EXIT_TEXT="Exit"

MESG="Current profile: $(powerprofilesctl get)"
CONFIG_PATH="$HOME/.config/rofi/rofi-power-profiles.conf"
THEME_PATH="$HOME/.config/rofi/rofi-power-profiles.rasi"

get_performance() {
  local profiles_list="$(powerprofilesctl list)"
  if [[ "$profiles_list" == *"performance"* ]]; then
    ORDER+=("$PERFORMANCE_TEXT")
  fi
}

initialize() {
  if [ -z "$CONFIG_PATH" ]; then
    source "$CONFIG_PATH"
  fi
  get_performance
  ORDER+=(
    "$BALANCED_TEXT"
    "$POWER_SAVER_TEXT"
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
  local keys=("${ORDER[@]}")

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
  fi

  powerprofilesctl set ${PROFILES["${option}"]}
}

initialize
chosen="$(options)"
run_cmd "$chosen"

