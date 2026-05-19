#!/bin/sh
status="$(protonvpn status)"

if echo "$status" | grep -qi "Disconnected"; then
    content="$(protonvpn connect)"
    notify-send "Proton VPN" "$content"
elif echo "$status" | grep -qi "Connected"; then
    content="$(protonvpn disconnect)"
    notify-send "Proton VPN" "$content"
else
    notify-send "Proton VPN" "unexpected error"
fi
