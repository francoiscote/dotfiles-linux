#!/bin/sh

# Switch to Workspace 5
twitch_workspace="5: "
i3-msg "workspace $twitch_workspace; append_layout /home/fcote/.i3/layouts/twitch-stream.json" &

# ------------------------
# Start Programs
# ------------------------

# Left Col: Chat, Dashboard, OBS
i3-msg "workspace $twitch_workspace; exec google-chrome-stable --new-window https://www.twitch.tv/popout/francois_js/chat"
i3-msg "workspace $twitch_workspace; exec google-chrome-stable --new-window https://www.twitch.tv/francois_js/dashboard"
i3-msg "workspace $twitch_workspace; exec obs"

# Middle Col: Main Browser and Editor
i3-msg "workspace $twitch_workspace; exec code -n"
i3-msg "workspace $twitch_workspace; exec google-chrome-stable --new-window https://github.com/francoiscote"

# Right Column: terminal, Alert Box
i3-msg "workspace $twitch_workspace; exec termite"
i3-msg "workspace $twitch_workspace; exec google-chrome-stable --new-window https://streamlabs.com/alert-box/v3/0EBC1BEE88B1EC9FD2D9"
