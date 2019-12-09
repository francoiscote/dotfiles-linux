#!/bin/bash

# Specifying the icon(s) in the script
# This allows us to change its appearance conditionally
active_player=$(playerctl -l 2> /dev/null)
if [[ $active_player = "spotify" ]]; then
  icon=""
else
  icon=""
fi

player_status=$(playerctl status 2> /dev/null)
if [[ $? -eq 0 ]]; then
    metadata="$(playerctl metadata artist) - $(playerctl metadata title)"
fi

# Foreground color formatting tags are optional
if [[ $player_status = "Playing" ]]; then
    echo "%{F#87b6b6}$icon $metadata"       # Green when playing
elif [[ $player_status = "Paused" ]]; then
    echo "%{F#ABB2BF}$icon $metadata"       # Greyed out info when paused
else
    echo "%{F#ABB2BF}$icon"                 # Greyed out icon when stopped
fi
