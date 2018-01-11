#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

xrdb .Xresources

# Keyboard Rate
xset r rate 180 60

exec i3
