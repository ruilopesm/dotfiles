#!/usr/bin/env bash

# Define the actions and their corresponding systemctl/Hyprland commands.
# The keys are what Rofi displays, values are the commands to execute.
declare -A options=(
    ["Suspend"]="systemctl suspend"
    ["Logout"]="hyprctl dispatch exit" # This command exits Hyprland
    ["Reboot"]="systemctl reboot"
    ["Shutdown"]="systemctl poweroff"
    # IMPORTANT: Only include "Hibernate" if you have configured it correctly
    # ["Hibernate"]="systemctl hibernate"
)

# Optional: Add icons if you have Nerd Fonts or equivalent
# This makes the Rofi menu look nicer.
# Comment out or remove these lines if you don't have Nerd Fonts or prefer plain text.
declare -A icons=(
    ["Suspend"]=""      # Moon / Sleep
    ["Logout"]=""       # Logout / Door
    ["Reboot"]=""       # Redo / Restart
    ["Shutdown"]=""     # Power off
    ["Hibernate"]=""    # Hibernate
)

# Build the menu string with icons (if enabled)
menu_string=""
for opt in "${!options[@]}"; do
    if [[ -n "${icons[$opt]}" ]]; then
        menu_string+="${icons[$opt]} ${opt}\n"
    else
        menu_string+="${opt}\n"
    fi
done

# Remove the trailing newline
menu_string="${menu_string%\\n}"

# Pipe the menu string to Rofi and capture the selected option
selected_option=$(echo -e "${menu_string}" | rofi -dmenu -i -p "Power")

# Extract just the option name if icons are used (e.g., " Suspend" -> "Suspend")
if [[ "$selected_option" =~ ^.*[[:space:]](.+)$ ]]; then
    selected_option="${BASH_REMATCH[1]}"
fi

# Execute the command corresponding to the selected option
if [[ -n "$selected_option" && -n "${options[$selected_option]}" ]]; then
    ${options[$selected_option]} &
else
    # User cancelled or selected nothing
    exit 0
fi
