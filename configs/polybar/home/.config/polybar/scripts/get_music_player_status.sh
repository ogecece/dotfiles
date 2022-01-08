#!/bin/bash

# Format of the information displayed
# Eg. {{ artist }} - {{ album }} - {{ title }}
# See more attributes here: https://github.com/altdesktop/playerctl/#printing-properties-and-metadata
METADATA_FORMAT="  {{ title }}      {{ artist }}"
METADATA_TRUNCATED_FORMAT="  {{ trunc(title, 30) }}      {{ trunc(artist, 20) }}"
STATUS_FORMAT="{{playerName}} :: {{status}}"

PLAYERCTL_STATUS=$(playerctl status --format "${STATUS_FORMAT}" --ignore-player chromium 2>/dev/null)
EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    STATUS=$PLAYERCTL_STATUS
else
    STATUS="No player is running"
fi

if [ "$1" == "--status" ]; then
    echo "$STATUS"
else
    # A note on hooks:
    # In the polybar config, they are supposed to be zero-indexed.
    # When making IPC calls, 1-based index numbers are to be used.
    # So don't get confused with hook value as 2.
    case "$STATUS" in
        *"Stopped")
            echo " "
            ;;
        *"Paused")
            echo "$(playerctl metadata --format "$METADATA_TRUNCATED_FORMAT" --ignore-player chromium)"
            ;;
        *"Playing")
            echo "$(playerctl metadata --format "$METADATA_FORMAT" --ignore-player chromium)"
            ;;
        *)
            echo ""
            ;;
    esac
fi
