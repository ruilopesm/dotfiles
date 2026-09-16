return function(_)
    local hostname = os.getenv("HOSTNAME")
    local hostname_file = io.open("/etc/hostname", "r")

    if hostname_file then
        hostname = hostname_file:read("*l") or hostname
        hostname_file:close()
    end

    local profiles = {
        tower = {
            output = "HDMI-A-1",
            mode = "2560x1440@143.91",
            position = "0x0",
            scale = 1.0,
        },

        thinkpad = {
            output = "eDP-1",
            mode = "1920x1080@59.99",
            position = "0x0",
            scale = 1.0,
        },
    }

    hl.monitor(profiles[hostname] or {
        output = "",
        mode = "preferred",
        position = "auto",
        scale = "auto",
    })
end
