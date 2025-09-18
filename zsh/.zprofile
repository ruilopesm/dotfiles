if [[ "$(tty)" == "/dev/tty1" ]]; then
    print -r -- "Starting hyprland..."
    exec hyprland >/dev/null 2>&1
fi
