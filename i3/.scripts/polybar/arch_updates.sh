#!/bin/bash
source /usr/share/fonts/awesome-terminal-fonts/fontawesome-regular.sh

pac=$(checkupdates | wc -l)
aur=$(yay -Qu --aur | wc -l)
check=$((pac + aur))
if [[ "$check" != "0" ]]
then
    echo -e "$pac %{F#5b5b5b}\u$CODEPOINT_OF_AWESOME_CLOUD_DOWNLOAD%{F-} $aur"
fi