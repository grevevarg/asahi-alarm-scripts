# asahi-alarm-scripts
Various asahi alarm helper scripts</br>
Mostly designed to configure a similar experience to macOS in some instances.</br>
Some of them assume that you're running hyprland as your desktop environment

Don't forget to make them executable with `chmod +x`

## enable_notch.sh

Checks if kernel parameter for notch has been explicitly set in grub config. If not, enables the notch.

## hyprland_twofinger_rightclick.sh

Not yet implemented. Basically supposed to just edit the `input` dictionary in hyprland config and add `clickfinger_behavior = 1` in the nested `touchpad` dictionary.</br>
Functionally this just means that instead of lightly tapping for right click, you press down on the touchpad.

## omarchy_move_waybar_modules.sh

Enabling the notch hides the middle modules when running waybar. This does a best effort attempt to move them to the left and right automatically.

## smartcopypaste.sh

Script that makes copy and paste have a single shortcut so you don't have to ctrl+shift+C/V if you're in a terminal and CTRL+C/V elsewhere.</br>
Also includes cut, cut doesn't work in terminal though fyi.</br>
place the file wherever you think makes sense, if unsure just make a scripts directory in your home folder. Don't forget to make it executable.

supposed to be invoked in `~/.config/hypr/bindings.conf` if running omarchy.</br>
example configuration:

```
bind = SUPER, C, exec, ~/scripts/smartcopypaste.sh copy $TERMINAL
bind = SUPER, V, exec, ~/scripts/smartcopypaste.sh paste $TERMINAL
bind = SUPER, X, exec, ~/scripts/smartcopypaste.sh cut $TERMINAL
```

if you're not running omarchy you won't have `$TERMINAL` defined and your configuration file might not be split up either.</br>
if you would like to only define the name of the terminal once you can add `$TERMINAL = nameofyourterminal` at the top of `hyprland.conf` or your custom keybind file to make sure its defined before the keybinds are actually loaded.</br>
you can also be explicit like

```
bind = SUPER, C, exec, ~/scripts/smartcopypaste.sh copy ghostty
bind = SUPER, V, exec, ~/scripts/smartcopypaste.sh paste ghostty
bind = SUPER, X, exec, ~/scripts/smartcopypaste.sh cut ghostty
```

the name matching for the terminal is done via substring matching. this might mean that if your terminal is `kitty` but you also have another program running with kitty as part of its name, the script will get confused.</br>
the script currently isn't case insensitive when checking the class name
