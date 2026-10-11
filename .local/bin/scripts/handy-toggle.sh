#!/bin/bash

STATE_FILE=/tmp/handy-transcription-state

if [[ -f "$STATE_FILE" ]]; then
    old_state=$(cat "$STATE_FILE")
else
    old_state="stopped"
fi

if [[ "$old_state" == "started" ]]; then
    new_state="stopped"
else
    new_state="started"
fi

NOTIFY_ID=4242
HISTORY_DB="$HOME/.local/share/com.pais.handy/history.db"

handy --toggle-transcription && echo "$new_state" > "$STATE_FILE" && {

if [[ "$new_state" == "stopped" && -f "$HISTORY_DB" ]]; then
    text=$(sqlite3 "$HISTORY_DB" "SELECT COALESCE(NULLIF(post_processed_text,''), transcription_text) FROM transcription_history ORDER BY id DESC LIMIT 1;" 2>/dev/null)
    if [[ -n "$text" ]]; then
        notify-send -r $NOTIFY_ID "Handy Transcription" "stopped — ${text:0:200}"
    else
        notify-send -r $NOTIFY_ID "Handy Transcription" "stopped"
    fi
else
    notify-send -r $NOTIFY_ID "Handy Transcription" "$new_state"
fi

}


