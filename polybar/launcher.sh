#!/usr/bin/env bash

LAPTOP_OUTPUT="eDP-1"
EXTERNAL_OUTPUT="HDMI-1-0"

CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$CONFIG_DIR/config.ini"

# Terminate already running bar instances
polybar-msg cmd quit 2> /dev/null
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if xrandr --query | grep -q "^${EXTERNAL_OUTPUT} connected"; then
  # External attached : main on HDMI, second on laptop
  export MAIN_MONITOR="$EXTERNAL_OUTPUT"
  export SECOND_MONITOR="$LAPTOP_OUTPUT"

  polybar main -c "$CONFIG_FILE" &
  sleep 0.5
  polybar second -c "$CONFIG_FILE" &
else
  # No external : only main on laptop
  export MAIN_MONITOR="$LAPTOP_OUTPUT"
  unset SECOND_MONITOR

  polybar main -c "$CONFIG_FILE" &
fi
