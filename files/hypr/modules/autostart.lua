return function(vars)
    hl.on("hyprland.start", function()
        hl.exec_cmd("openrgb --profile " .. vars.config_home .. "/OpenRGB/Off.orp")

        hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
        hl.exec_cmd("systemctl --user import-environment QT_QPA_PLATFORMTHEME")
        hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

        hl.exec_cmd("hyprctl setcursor Vimix-cursors 24")
        hl.exec_cmd("dunst")
        hl.exec_cmd("hyprpaper --config " .. vars.dotfiles .. "/files/hypr/hyprpaper.conf")
        hl.exec_cmd("elephant")
        hl.exec_cmd("walker --gapplication-service")
        hl.exec_cmd("emote")

        hl.exec_cmd("nm-applet")
        hl.exec_cmd("blueman-applet")
        hl.exec_cmd("Telegram -startintray")
        hl.exec_cmd("mattermost-desktop --hidden")
        -- hl.exec_cmd("slack -u")
        -- hl.exec_cmd("teams-for-linux --minimized")

        hl.exec_cmd("waybar")
    end)
end
