(use-modules (gnu home)
             (gnu home services)
             (gnu packages wm)
             (gnu packages qt)
             (guix gexp))

(home-environment
 (packages (list hyprland qtwayland))

 (services
  (list
   (simple-service 'qt-wayland-env
                    home-environment-variables-service-type
                    '(("QT_QPA_PLATFORM" . "wayland;xcb")))

   (simple-service 'dotfiles
                    home-files-service-type
                    (list
                     (list ".config/hypr/hyprland.conf"
                           (plain-file "hyprland.conf" "\
env = LIBVA_DRIVER_NAME,nvidia
env = GBM_BACKEND,nvidia-drm
env = __GLX_VENDOR_LIBRARY_NAME,nvidia
env = WLR_NO_HARDWARE_CURSORS,1
env = AQ_DRM_DEVICES,/dev/dri/card0

monitor=,preferred,auto,1

exec-once = dbus-update-activation-environment --systemd --all
exec-once = /run/current-system/profile/bin/polkit-gnome-authentication-agent-1
exec-once = waybar

input {
    kb_layout = us,ru
    kb_options = grp:alt_shift_toggle
    follow_mouse = 1
    force_no_accel = true
    accel_profile = "flat"
}

general {
    gaps_in = 5
    gaps_out = 10
    border_size = 2
}

$mainMod = SUPER

bind = $mainMod, Return, exec, alacritty
bind = $mainMod, Q, killactive,
bind = $mainMod, D, exec, rofi -show drun
bind = $mainMod, B, exec, qutebrowser
")
                     (list ".config/qutebrowser/config.py"
                           (plain-file "qutebrowser-config.py" "\
config.load_autoconfig()

c.colors.webpage.preferred_color_scheme = 'dark'
c.content.blocking.method = 'both'
c.tabs.position = 'top'
c.editor.command = ['nvim', '{file}']

config.bind('d', 'tab-close')
config.bind('J', 'tab-prev')
config.bind('K', 'tab-next')
")))))))
