#!/bin/sh


# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch polybar on both external monitors
MONITOR=DP-0 polybar top &
#MONITOR=DP1-2 polybar top &

echo "Bars launched..."
