#!/bin/bash

scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png

i3lock -e -n -i /tmp/screen.png
