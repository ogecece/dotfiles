#!/bin/bash

# see man zscroll for documentation of the following parameters
zscroll \
  -l 60 \
  --delay 0.1 \
  --scroll-padding "    " \
  --match-command "$HOME/.config/polybar/scripts/get_spotify_status.sh --status" \
  --match-text "No player is running" "" \
  --match-text "youtubemusic :: Stopped" "--before-text '   栗'" \
  --match-text "youtubemusic :: Paused" "--scroll 0 --before-text '   契    '" \
  --match-text "youtubemusic :: Playing" "--scroll 1 --before-text '       '" \
  --match-text "spotify :: Stopped" "--before-text '阮   栗'" \
  --match-text "spotify :: Paused" "--scroll 0 --before-text '阮   契    '" \
  --match-text "spotify :: Playing" "--scroll 1 --before-text '阮       '" \
  --update-check true "$HOME/.config/polybar/scripts/get_spotify_status.sh" \
  2>/dev/null &

wait
