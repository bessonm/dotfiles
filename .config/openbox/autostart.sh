compton &

# Wallpaper
~/.fehbg &

# Bars
sh ~/.config/polybar/launch.sh &

# Launcher
(sleep 1 && albert) &

# Theme
(sleep 1 && wal -R -n -e)
(sleep 1 && xbanish) &

# Disable screensaver on fullscreen
(sleep 1 && ./lightson+ -d 2) &
