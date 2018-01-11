#!/bin/sh
i3-msg 'workspace "5: "; append_layout /home/fcote/.i3/layouts/twitch-stream.json'

# Set Wallpaper
exec --no-startup-id feh --no-fehbg --bg-fill ~/Pictures/wallpapers/stars01.jpg &

# Remove Gaps

# Start Programs
exec code -n &
exec obs &
exec chromium --new-window https://www.twitch.tv/francois_js/dashboard &
exec termite &
exec termite &
exec chromium --new-window https://go.twitch.tv/popout/francois_js/chat
