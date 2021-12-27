#!/bin/sh

# start USB automounter
pgrep udiskie || udiskie &

# activate lock screen on suspend/hibernate
# pgrep xss-lock || XSECURELOCK_NO_COMPOSITE=1 xss-lock -n /usr/lib/xsecurelock/dimmer -l -- multilockscreen --lock &

# change keyboard layout
setxkbmap -layout us -variant altgr-intl -option caps:swapescape

# start key binder
pgrep sxhkd || sxhkd &

# start print screen daemon
pgrep flameshot || flameshot &

# set multi-monitor layout
#~/.config/.screenlayout/home.sh
~/.config/.screenlayout/home-vga.sh

# set wallpaper
feh --bg-scale ~/.config/wallpaper.png

# start compositor
pgrep picom || picom -b --experimental-backends

# set cursor shape to left pointer
xsetroot -cursor_name left_ptr

# start window manager
pgrep bspwm || exec bspwm
