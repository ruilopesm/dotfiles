return function(_)
    hl.config({
        general = {
            border_size = 2,
            gaps_in = 5,
            gaps_out = 10,
            col = {
                active_border = {
                    colors = { "rgba(595959aa)", "rgba(ffffffaa)" },
                    angle = 45,
                },
                inactive_border = "rgba(595959aa)",
            },
            layout = "dwindle",
            resize_on_border = false,
            allow_tearing = false,
        },

        dwindle = {
            force_split = 2,
            preserve_split = true,
            precise_mouse_move = true,
        },

        decoration = {
            rounding = 2,
            active_opacity = 1.0,
            inactive_opacity = 1.0,
            shadow = {
                enabled = false,
            },
            blur = {
                enabled = false,
            },
        },

        animations = {
            enabled = true,
        },

        misc = {
            disable_hyprland_logo = true,
            disable_splash_rendering = true,
            font_family = "Fira Code",
            always_follow_on_dnd = true,
            focus_on_activate = true,
            middle_click_paste = false,
            initial_workspace_tracking = 0,
        },

        ecosystem = {
            no_donation_nag = true,
        },

        debug = {
            disable_logs = false,
            enable_stdout_logs = true,
            gl_debugging = true,
        },
    })
end
