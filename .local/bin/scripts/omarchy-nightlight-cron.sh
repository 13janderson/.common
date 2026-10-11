#!/bin/bash

ON_TEMP=4000
OFF_TEMP=6000

PATH="/home/janderson/.local/share/omarchy/bin:/usr/local/bin:/usr/bin:/bin:$PATH"

export XDG_RUNTIME_DIR="/run/user/$(id -u)"
eval "$(systemctl --user show-environment 2>/dev/null | grep -E '^(WAYLAND_DISPLAY|HYPRLAND_INSTANCE_SIGNATURE|DBUS_SESSION_BUS_ADDRESS)=')"
export WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE DBUS_SESSION_BUS_ADDRESS

[ -z "$HYPRLAND_INSTANCE_SIGNATURE" ] && exit 0
[ -z "$WAYLAND_DISPLAY" ] && exit 0

# Ensure hyprsunset is running
if ! pgrep -x hyprsunset >/dev/null 2>&1; then
  setsid hyprsunset >/dev/null 2>&1 &
  sleep 1
fi

h=$(date +%H)
if [ "$h" -ge 20 ] || [ "$h" -lt 6 ]; then
  target=$ON_TEMP
  marker_should_exist=true
else
  target=$OFF_TEMP
  marker_should_exist=false
fi

# Only change state if it's actually wrong (handles reboots / manual tweaks)
current=$(hyprctl hyprsunset temperature 2>/dev/null | grep -oE '[0-9]+' | head -n1)
if [ "$current" = "$target" ]; then
  [ "$marker_should_exist" = true ] && touch /tmp/nightlight || rm -f /tmp/nightlight
  exit 0
fi

hyprctl hyprsunset temperature "$target" >/dev/null 2>&1

if [ "$marker_should_exist" = true ]; then
  touch /tmp/nightlight
  notify-send -u low "  Nightlight screen temperature" >/dev/null 2>&1
else
  rm -f /tmp/nightlight
  notify-send -u low "   Daylight screen temperature" >/dev/null 2>&1
fi
