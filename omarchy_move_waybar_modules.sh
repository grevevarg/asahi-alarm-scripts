#!/usr/bin/env bash
set -euo pipefail

echo "This script assumes default install location and values under Omarchy."
echo "Anything custom will be overwritten. You'll be given the option to back up your config."
default_path="$HOME/.config/waybar/config.jsonc"
backup_path="${default_path}.bak"
tmp_path="$(mktemp)"


echo "Checking if file can be parsed with jq"
jq empty "$default_path"

read -rp "Would you like to back up the original file? (y/N): " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
  cp "$default_path" "$backup_path"
  echo "Backup created at: $backup_path"
else
  echo "No backup"
fi

jq '
  .height = 32
  | .["modules-left"] += ["custom/update"]
  | .["modules-center"] = []
  | .["modules-right"] = [
      "group/tray-expander",
      "custom/screenrecording-indicator",
      "bluetooth",
      "network",
      "pulseaudio",
      "cpu",
      "battery",
      "clock"
    ]
' "$default_path" > "$tmp_path"

mv "$tmp_path" "$default_path"
echo "Config at $default_path overwritten, force reloading waybar & exiting"
pkill -SIGUSR2 waybar

exit
