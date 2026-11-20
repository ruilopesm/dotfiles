# System login profiles can reset PATH and MANPATH.
source "$HOME/.zshenv"

if [[ "$(tty)" == "/dev/tty1" ]]; then
    print -r -- "Starting hyprland..."
    log_dir="${XDG_STATE_HOME:-$HOME/.local/state}/hyprland"
    mkdir -p "$log_dir"
    exec start-hyprland > "$log_dir/start-hyprland.log" 2>&1
fi
