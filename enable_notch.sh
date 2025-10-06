#!usr/bin/env bash

set -euo pipefail

DROPIN_FOLDER="/etc/default/grub.d"
DROPIN_FILE="$DROPIN_FOLDER/enable_notch.cfg"

if sudo grep -q "apple_dcp.show_notch" /boot/grub/grub.cfg; then
    echo "Notch mode already set in GRUB config."
    echo "Check /etc/default/grub or /etc/default/grub.d/*.conf to see where it’s set."
    echo "If you change it, run: sudo grub-mkconfig -o /boot/grub/grub.cfg"
    echo "And then reboot"
    exit 0
fi

if [ ! -d "$DROPIN_FOLDER" ]; then
    sudo mkdir -p "$DROPIN_FOLDER"
fi

CURRENT_LINE=$(grep "^GRUB_CMDLINE_LINUX_DEFAULT=" /etc/default/grub | cut -d= -f2- | tr -d '"')
NEW_LINE="$CURRENT_LINE apple_dcp.show_notch=1"

echo "Creating drop in file at $DROPIN_FILE"
echo "GRUB_CMDLINE_LINUX_DEFAULT=\"$NEW_LINE\"" | sudo tee "$DROPIN_FILE" > /dev/null

echo "Rebuilding GRUB config"

sudo grub-mkconfig -o /boot/grub/grub.cfg

read -rp "System reboot required. Reboot now? [y/n]: " REBOOT_ANSWER

case "$REBOOT_ANSWER" in
    [yY])
        echo "Rebooting..."
        sudo systemctl reboot
        ;;
    [nN])
        echo "Skipping reboot, notch will only be enabled after rebooting"
        ;;
    *)
        echo "Nice try"
        ;;
esac
