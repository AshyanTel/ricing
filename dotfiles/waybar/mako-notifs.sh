#!/bin/sh
history_json=$(makoctl history -j)

count=$(echo "$history_json" | jq 'length')

icon_notif="󱅫"   
icon_none="󰂚"

if [ "$count" -gt 0 ]; then
    tooltip=$(echo "$history_json" | jq -r '
        [.[] | "\(.app_name): \(.summary)" + (if .body then "\n  " + .body else "" end)]
        | join("\n")')
    tooltip_escaped=$(echo "$tooltip" | sed ':a;N;$!ba;s/\n/\\n/g' | sed 's/"/\\"/g')
    printf '{"text": "%s %s", "tooltip": "%s", "class": "notification"}\n' "$icon_notif" "$count" "$tooltip_escaped"
else
    printf '{"text": "%s", "tooltip": "Aucune notification manquée", "class": "none"}\n' "$icon_none"
fi
