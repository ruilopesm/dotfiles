local home = assert(os.getenv("HOME"), "HOME is not set")
local dotfiles = home .. "/dotfiles"

return {
    home = home,
    dotfiles = dotfiles,
    config_home = os.getenv("XDG_CONFIG_HOME") or home .. "/.config",
    main_mod = "SUPER",
    terminal = "alacritty",
    file_manager = "nemo",
    menu = "walker",
    screenshot = dotfiles .. "/files/scripts/screenshot",
}
