#!/usr/bin/env bash
# ---
# Use "run program" to run it only if it is not already running
# Use "program &" to run it regardless
# ---
# NOTE: This script runs with every restart of AwesomeWM
# If you would like to run a command *once* on login,
# you can use ~/.xprofile

function run {
  if ! pgrep $1 > /dev/null ;
  then
    $@&
  fi
}

# Load terminal colorscheme and settings
#xrdb ~/.Xresources

# Compositor
run picom -b

# Polkit auth agent
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1

run greenclip daemon

# Applets
run blueman-applet
run redshift-gtk
run nm-applet