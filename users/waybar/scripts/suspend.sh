#!/usr/bin/env bash

confirm_action() {
    local action="$1"
    CONFIRMATION="$(printf "No\nYes" | fuzzel --dmenu -a bottom-right -l 2 -w 18 -p "$action?")"
    [[ "$CONFIRMATION" == *"Yes"* ]]
}

if confirm_action "Suspend"; then
    systemctl suspend
fi;
