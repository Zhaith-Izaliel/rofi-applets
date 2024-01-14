#!/usr/bin/env bash

# Config
STOP_TEXT=""
PREVIOUS_TEXT="󰒮"
NEXT_TEXT="󰒭"
REPEAT_TEXT=""
RANDOM_TEXT=""
PAUSE_TEXT=""
PLAY_TEXT=""
PARSE_ERROR_TEXT=""
NO_SONG_TEXT="󰟎"

# Notifications
NOTIFICATION=true
PREVIOUS_NOTIFICATION_TEXT="󰒮 Playing"
PREVIOUS_NOTIFICATION_ICON=""
NEXT_NOTIFICATION_TEXT="󰒭 Playing"
NEXT_NOTIFICATION_ICON=""
PLAY_NOTIFICATION_TEXT=" Playing"
PLAY_NOTIFICATION_ICON=""
PAUSE_NOTIFICATION_TEXT=" Pausing"
PAUSE_NOTIFICATION_ICON=""

# Globals
THEME_PATH="$HOME/.config/rofi/rofi-mpd.rasi"
CONF_PATH="$HOME/.config/rofi/rofi-mpd.conf"
STATUS="`mpc status`"
PROMPT=""
MESG=""

# Colorize toggle actions
ACTIVE=""
URGENT=""

declare -A OPTIONS
OPTIONS=()

read_config() {
  if [ -f "$CONF_PATH" ]; then
    source "$CONF_PATH"
  fi
}

init_array() {
  OPTIONS=(
    ["previous"]="$PREVIOUS_TEXT"
    ["toggle"]="$([[ ${STATUS} == *"[playing]"* ]] && echo "$PAUSE_TEXT" || echo "$PLAY_TEXT")"
    ["stop"]="$STOP_TEXT"
    ["next"]="$NEXT_TEXT"
    ["repeat"]="$REPEAT_TEXT"
    ["random"]="$RANDOM_TEXT"
  )
}

init_prompt_and_message() {
  if [[ -z "$STATUS" ]]; then
    PROMPT="Offline"
    MESG="MPD is Offline"
    return
  fi

  PROMPT="`mpc -f "%artist%" current`"
  MESG="`mpc -f "%title%" current` ⎸`mpc status | grep "#" | awk '{print $3}'`"
}

init_repeat() {
  if [[ ${STATUS} == *"repeat: on"* ]]; then
    ACTIVE="-a 4"
  elif [[ ${STATUS} == *"repeat: off"* ]]; then
    ACTIVE=""
  else
    OPTIONS["repeat"]="$PARSE_ERROR_TEXT"
  fi
}

init_random() {
  # Random
  if [[ ${STATUS} == *"random: on"* ]]; then
    [ -n "$ACTIVE" ] && ACTIVE+=",5" || ACTIVE="-a 5"
  elif [[ ${STATUS} == *"random: off"* ]]; then
    ACTIVE+=""
  else
    OPTIONS["random"]="$PARSE_ERROR_TEXT"
  fi
}

initialize() {
  read_config
  init_array
  init_prompt_and_message
  init_repeat
  init_random
}

rofi_cmd() {
  if [ -f "$THEME_PATH" ]; then
    rofi -dmenu \
      ${ACTIVE} \
      -p "$PROMPT" \
      -mesg "$MESG" \
      -theme "$THEME_PATH"
  else
    rofi -dmenu \
      ${ACTIVE} \
      -p "$PROMPT" \
      -mesg "$MESG"
  fi
}

pass_options() {
  if ! [[ "${STATUS}" =~ ^.*(playing|paused).*$ ]]; then
    echo -e "${NO_SONG_TEXT}" | rofi_cmd
  else
    echo -e "${OPTIONS["previous"]}\n${OPTIONS["toggle"]}\n${OPTIONS["stop"]}\n${OPTIONS["next"]}\n${OPTIONS["repeat"]}\n${OPTIONS["random"]}" | rofi_cmd
  fi
}

show_notification() {
  if [ "$NOTIFICATION" != true ]; then
    return
  fi

  case "$1" in
    --toggle)
      if [[ "${STATUS}" == *"[playing]"* ]]; then
        notify-send -u low -i "$PAUSE_NOTIFICATION_ICON" "$PAUSE_NOTIFICATION_TEXT `mpc current`"
      else
        notify-send -u low -i "$PLAY_NOTIFICATION_ICON" "$PLAY_NOTIFICATION_TEXT `mpc current`"
      fi
      ;;
    --next)
      notify-send -u low -i "$NEXT_NOTIFICATION_ICON" "$NEXT_NOTIFICATION_TEXT `mpc current`"
      ;;
    --prev)
      notify-send -u low -i "$PREVIOUS_NOTIFICATION_ICON" "$PREVIOUS_NOTIFICATION_TEXT `mpc current`"
      ;;
  esac
}

run() {
  case "$1" in
    --toggle)
      mpc -q toggle
      ;;
    --stop)
      mpc -q stop
      ;;
    --next)
      mpc -q next
      ;;
    --prev)
      mpc -q prev
      ;;
    --repeat)
      mpc -q repeat
      ;;
    --random)
      mpc -q random
      ;;
  esac
  show_notification "$1"
}

main() {
  initialize
  chosen="$(pass_options)"
  case "${chosen}" in
    ${OPTIONS["repeat"]})
      run --repeat
      ;;
    ${OPTIONS["random"]})
      run --random
      ;;
    ${OPTIONS["toggle"]})
      run --toggle
      ;;
    ${OPTIONS["next"]})
      run --next
      ;;
    ${OPTIONS["previous"]})
      run --prev
      ;;
    ${OPTIONS["stop"]})
      run --stop
      ;;
  esac
}

main

