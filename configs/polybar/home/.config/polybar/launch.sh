#!/usr/bin/env sh
IFS=$'\n\t'

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

count=$(xrandr --query | grep " connected" | cut -d" " -f1 | wc -l)

if [ $count = 1 ]; then
  m=$(xrandr --query | grep " connected" | cut -d" " -f1)
  MONITOR=$m polybar --reload mainbar -c ~/.config/polybar/config &
else
  for monitor in $(xrandr --query | grep " connected"); do
    is_primary=$(echo "$monitor" | grep " primary")
    m=$(echo "$monitor" | cut -d" " -f1)
    if [[ $is_primary ]]; then
      MONITOR=$m polybar --reload mainbar -c ~/.config/polybar/config &
    else
      MONITOR=$m polybar --reload extrabar -c ~/.config/polybar/config &
    fi
  done
fi
