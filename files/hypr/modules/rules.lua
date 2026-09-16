return function(_)
    -- Ignore maximize requests from apps
    hl.window_rule({
        name = "suppress_maximize_requests",
        match = {
            class = ".*",
        },
        suppress_event = "maximize",
    })

    -- Fix some dragging issues with XWayland
    hl.window_rule({
        name = "fix_xwayland_drag_focus",
        match = {
            class = "^$",
            title = "^$",
            xwayland = true,
            float = false,
            fullscreen = false,
            pin = false,
        },
        no_focus = true,
    })
end
