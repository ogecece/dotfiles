#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

#starting utility applications at boot time
run variety &
run nm-applet &
run pamac-tray &
run xfce4-power-manager &
run xfce4-clipman &
run volumeicon &
run clight &
# numlockx on &
blueberry-tray &
picom --config $HOME/.config/picom/picom.conf &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
playerctld daemon

(sleep 2; run $HOME/.config/polybar/launch.sh) &

#change your keyboard if you need it
#setxkbmap -layout be

# swap caps lock with escape
setxkbmap -option caps:swapescape

#cursor active at boot
xsetroot -cursor_name left_ptr &
