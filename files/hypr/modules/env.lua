return function(vars)
    hl.env("HOME", vars.home)
    hl.env("DOTFILES_DIRECTORY", vars.dotfiles)
    hl.env("XDG_CONFIG_HOME", vars.config_home)

    hl.env("LIBVA_DRIVER_NAME", "iHD")
    hl.env("XCURSOR_SIZE", "24")
    hl.env("HYPRCURSOR_SIZE", "24")
    hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
    hl.env("GTK_THEME", "Adwaita:dark")
    hl.env("GTK2_RC_FILES", "/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc")
end
