#!/bin/bash

if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED; then
    echo '{"text":"󰍭","class":"muted","tooltip":"Micro coupé"}'
else
    echo '{"text":"󰍬","class":"unmuted","tooltip":"Micro actif"}'
fi
