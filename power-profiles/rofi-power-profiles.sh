#!/usr/bin/env bash

PERFORMANCE_TEXT="Performance"
BALANCED_TEXT="Balanced"
POWER_SAVER_TEXT="Power saver"
declare -A PROFILES
PROFILES=()
ORDER=()
PROMPT="Power Profiles Daemon"
EXIT_TEXT="Exit"

MESG="Current profile: $(powerprofilesctl get)"
CONFIG_PATH="$HOME/.config/rofi/rofi-power-profiles.conf"
THEME_PATH="$HOME/.config/rofi/rofi-power-profiles.rasi"

get_profiles() {
  PROFILES=(
    ["$POWER_SAVER_TEXT"]="power-saver"
    ["$BALANCED_TEXT"]="balanced"
    ["$PERFORMANCE_TEXT"]="performance"
  )

  local profiles_list="$(powerprofilesctl list)"

  if [[ "$profiles_list" == *"performance"* ]]; then
    ORDER+=("$PERFORMANCE_TEXT")
  fi

  ORDER+=(
    "$BALANCED_TEXT"
    "$POWER_SAVER_TEXT"
  )
}

initialize() {
  if [ -f "$CONFIG_PATH" ]; then
    source "$CONFIG_PATH"
  fi
  get_profiles
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

