return function(_)
    hl.config({
        input = {
            kb_layout = "pt",
            follow_mouse = 1,
            focus_on_close = 1,
            sensitivity = -0.8,
            touchpad = {
                natural_scroll = false,
            },
        },
    })

    hl.device({
        name = "synaptics-tm3471-020",
        sensitivity = 0,
        tap_to_click = true,
    })

    hl.gesture({
        fingers = 3,
        direction = "horizontal",
        action = "workspace",
    })
end
