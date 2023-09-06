#!/bin/bash

function run {
  if ! pgrep -x $1 ;
  then
    bash -c "$2 &"
  fi
}

function restart {
  pkill $1
  bash -c "$2 &"
}

# set monitors
autorandr --change --default common

# set temporary background
feh --bg-center ~/.config/variety/Enabled/wallpaper.png

# cursor active at boot
xsetroot -xcf /usr/share/icons/Bibata-Modern-Ice/cursors/left_ptr 16

# restart polybar
$HOME/.config/polybar/launch.sh &

# starting utility applications at boot time
run "variety" "variety"
run "nm-applet" "nm-applet"
run "pamac-tray" "pamac-tray"
run "xfce4-power-man" "xfce4-power-manager"
run "xfce4-clipman" "xfce4-clipman"
run "pnmixer" "pnmixer"
run "clight" "clight"
run "clight-gui" "clight-gui --tray"
run "blueberry-tray" "blueberry-tray"
run "polkit-gnome-au" "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
run "xfce4-notifyd" "/usr/lib/xfce4/notifyd/xfce4-notifyd"
run "playerctld" "playerctld daemon"
restart "picom" "picom -b --config ~/.config/picom/picom.conf"

# change your keyboard if you need it
setxkbmap -layout br

# swap caps lock with escape
setxkbmap -option caps:swapescape

xdo lower -m -N 'Polybar' &
