#!/bin/sh

feh --randomize --no-fehbg --bg-scale $HOME/images/
emacs --daemon
picom &

dwmblocks &

# setxkbmap 'us,ru' -option 'grp:alt_shift_toggle'
# setxkbmap -option 'caps:escape'
#
# pipewire &
# pipewire-pulse &
# wireplumber &


while true; do
    # Log stderror to a file
	dwm 2>~/.dwm.log
	# No error logging
	#dwm >/dev/null 2>&1
done
