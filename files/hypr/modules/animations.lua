return function(_)
    local curves = {
        { "ease_out_quint",    { { 0.23, 1 },    { 0.32, 1 } } },
        { "ease_in_out_cubic", { { 0.65, 0.05 }, { 0.36, 1 } } },
        { "linear",            { { 0, 0 },       { 1, 1 } } },
        { "almost_linear",     { { 0.5, 0.5 },   { 0.75, 1.0 } } },
        { "quick",             { { 0.15, 0 },    { 0.1, 1 } } },
    }

    for _, curve in ipairs(curves) do
        hl.curve(curve[1], { type = "bezier", points = curve[2] })
    end

    local animations = {
        { leaf = "global",        enabled = true, speed = 10,   bezier = "default" },
        { leaf = "border",        enabled = true, speed = 5.39, bezier = "ease_out_quint" },
        { leaf = "windows",       enabled = true, speed = 4.79, bezier = "ease_out_quint" },
        { leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "ease_out_quint", style = "popin 87%" },
        { leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" },
        { leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almost_linear" },
        { leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almost_linear" },
        { leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" },
        { leaf = "layers",        enabled = true, speed = 3.81, bezier = "ease_out_quint" },
        { leaf = "layersIn",      enabled = true, speed = 4,    bezier = "ease_out_quint", style = "fade" },
        { leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" },
        { leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almost_linear" },
        { leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almost_linear" },
        { leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almost_linear", style = "fade" },
        { leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almost_linear", style = "fade" },
        { leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almost_linear", style = "fade" },
    }

    for _, animation in ipairs(animations) do
        hl.animation(animation)
    end
end
