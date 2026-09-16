return function(vars)
    local main_mod = vars.main_mod

    -- Custom
    hl.bind(main_mod .. " + RETURN", hl.dsp.exec_cmd(vars.terminal))
    hl.bind(main_mod .. " + E", hl.dsp.exec_cmd(vars.file_manager))
    hl.bind(main_mod .. " + D", hl.dsp.exec_cmd(vars.menu))

    hl.bind(main_mod .. " + SHIFT + P", hl.dsp.exec_cmd("playerctl play-pause"))
    hl.bind("CTRL + ESCAPE", hl.dsp.exec_cmd(vars.menu .. " -n -m menus:power"))

    hl.bind("CTRL + code:21", hl.dsp.exec_cmd(vars.screenshot)) -- «
    hl.bind("CTRL + code:107", hl.dsp.exec_cmd(vars.screenshot)) -- Stamp @ thinkpad
    hl.bind("CTRL + code:115", hl.dsp.exec_cmd(vars.screenshot)) -- PRT SC @ omen

    -- Laptop multimedia keys for audio control
    hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
    hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
    hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
    hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
    hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
    hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
    hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
    hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

    -- Laptop keys for brightness control
    hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
    hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

    hl.bind(main_mod .. " + W", hl.dsp.window.close())
    hl.bind(main_mod .. " + F", hl.dsp.window.fullscreen())
    hl.bind(main_mod .. " + S", hl.dsp.window.float())
    hl.bind(main_mod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle
    hl.bind("SUPER + SHIFT + M", hl.dsp.exit())

    -- Move focus with the main modifier + arrow keys
    hl.bind(main_mod .. " + left", hl.dsp.focus({ direction = "left" }))
    hl.bind(main_mod .. " + right", hl.dsp.focus({ direction = "right" }))
    hl.bind(main_mod .. " + up", hl.dsp.focus({ direction = "up" }))
    hl.bind(main_mod .. " + down", hl.dsp.focus({ direction = "down" }))

    -- Switch workspaces and silently move windows with the main modifier + [0-9]
    for workspace = 1, 10 do
        local key = workspace % 10
        hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
        hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({
            workspace = workspace,
            follow = false,
        }))
    end

    -- Move/resize windows with the main modifier + LMB/RMB and dragging
    hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
    hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
end
