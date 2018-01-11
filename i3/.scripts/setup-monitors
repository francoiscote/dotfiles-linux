#!/bin/sh

laptop="eDP1"
external1="DP1"
external2="DP2"
hdmi="HDMI1"

if (xrandr | grep -e "^$external1 connected"); then

  xrandr --output $laptop --off \
    --output $hdmi --off \
    --output $external2 --off \
    --output $external1 --primary --auto --scale 1x1
  xrandr --dpi 94

else if (xrandr | grep -e "^$external2 connected"); then

  xrandr --output $laptop --off \
    --output $hdmi --off \
    --output $external1 --off \
    --output $external2 --primary --auto --scale 1x1
  xrandr --dpi 94

else

  xrandr --output $external1 --off \
    --output $external2 --off \
    --output $hdmi --off \
    --output $laptop --primary --auto --scale 1x1
  xrandr --dpi 168

fi