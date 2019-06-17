#!/bin/bash
pac=$(checkupdates | wc -l)
# aur=$(cower -u --timeout=20 | wc -l)
aur=0
check=$((pac + aur))
if [[ "$check" != "0" ]]
then
    echo "$pac %{F#5b5b5b}%{F-} $aur"
fi
