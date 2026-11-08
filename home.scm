(add-to-load-path "/home/noname/guix")
(add-to-load-path "/home/noname/guix/packages")
(use-modules (gnu home)
             (gnu home services)
             (guix gexp)
	     (nonguix transformations)
             (prism_pkg)
             (gnu packages freedesktop)
             (gnu packages shells)
             (gnu packages shellutils)
             (gnu packages rust-apps)
             (gnu packages algebra)
             (gnu packages w3m)
             (gnu packages disk)
             (gnu packages video)
             (gnu packages pulseaudio)
             (vesktop_pkg)
	     (nongnu packages nvidia)
             (guix packages)
             (nongnu packages game-client)
             (nonguix multiarch-container)
             (stylix theme)
             (stylix hyprland)
             (stylix waybar)
             (stylix alacritty)
             (stylix qute)
             (stylix gtk)
             (stylix zsh)
             (stylix yazi))
(define nvidia-transform (nonguix-transformation-nvidia #:driver nvda-620))
(define %Anyone
(home-environment
;;packages
(packages (list
           (@ (gnu packages window-management) hyprland)
           (@ (gnu packages xdisorg) hyprpaper)
           (@ (gnu packages window-management) waybar)
           (@ (gnu packages xdisorg) rofi)
           (@ (gnu packages terminals) alacritty)
	   (@ (nongnu packages nvidia) nvidia-prime)
	   (@ (gnu packages gl) mesa-utils)
           (@ (gnu packages web-browsers) qutebrowser)
           (@ (gnu packages vim) neovim)
           (@ (gnu packages version-control) git)
           (@ (gnu packages freedesktop) xdg-utils)
           (@ (gnu packages freedesktop) xdg-desktop-portal)
           (@ (gnu packages freedesktop) xdg-desktop-portal-hyprland)   
           (@ (gnu packages qt) qtwayland)
           (@ (gnu packages qt) qt5ct)
           (@ (gnu packages qt) qt6ct)
           (@ (gnu packages admin) neofetch)
           (@ (gnu packages qt) kvantum)
           (@ (gnu packages polkit) polkit-gnome)
           (@ (gnu packages linux) brightnessctl)
           (@ (gnu packages linux) wireplumber)
           (@ (gnu packages fonts) font-jetbrains-mono)
           (@ (gnu packages fonts) font-nerd-symbols)
           (@ (gnu packages xorg) xcursor-themes)
           (@ (gnu packages telegram) telegram-desktop)
           (@ (nongnu packages editors) vscodium)
           (@ (nongnu packages game-client) steam)
           vesktop
	   prism

           (@ (gnu packages shells) zsh)
           (@ (gnu packages shellutils) zsh-syntax-highlighting)
           (@ (gnu packages shellutils) zsh-autosuggestions)
           (@ (gnu packages rust-apps) eza)
           (@ (gnu packages rust-apps) bat)
           (@ (gnu packages rust-apps) bottom)
           (@ (gnu packages rust-apps) fd)
           (@ (gnu packages algebra) bc)
           (@ (gnu packages w3m) w3m)
           (@ (gnu packages disk) yazi)
           (@ (gnu packages video) mpv)
           (@ (gnu packages pulseaudio) pavucontrol)
           (@ (gnu packages freedesktop) xdg-desktop-portal-termfilechooser)
           (@ (gnu packages shellutils) direnv)))

  ;;services
  (services
    (list
      (simple-service 'qt-wayland-env
                      home-environment-variables-service-type
                      '(("QT_QPA_PLATFORM" . "wayland;xcb")
                        ("QT_QPA_PLATFORMTHEME" . "qt6ct")
                        ("QT_WAYLAND_DISABLE_WINDOWDECORATION" . "1")
                        ("GTK_CSD" . "0")
                        ("QTWEBENGINE_CHROMIUM_FLAGS" . "--disable-gpu")
                        ("ALACRITTY_LOG" . "error")
                        ("TERMCMD" . "alacritty --class filechoose_yazi")))

      (simple-service 'prime-render-offload
                      home-environment-variables-service-type
                      '(("__NV_PRIME_RENDER_OFFLOAD" . "1")
                        ("__VK_LAYER_NV_optimus" . "NVIDIA_only")))

      ;;files
      (simple-service 'stylix-dotfiles
                      home-files-service-type
                      (list
                        (list ".config/hypr/hyprland.lua"
                              (plain-file "hyprland.lua" hyprland-config))
                        (list ".config/hypr/hyprpaper.conf"
                              (plain-file "hyprpaper.conf" hyprpaper-conf))
                        (list ".config/hypr/shaders/vibrance.frag"
                              (plain-file "vibrance.frag" vibrance-frag))
                        (list ".config/hypr/wallpaper.jpg"
                              (local-file "stylix/wallpaper.jpg"))

                        (list ".zshrc"
                              (plain-file "zshrc" zshrc))

                        (list ".zprofile"
                              (plain-file "zprofile" zprofile))

                        (list ".config/waybar/config.jsonc"
                              (plain-file "waybar-config.jsonc" waybar-config-json))
                        (list ".config/waybar/style.css"
                              (plain-file "waybar-style.css" waybar-style-css))

                        (list ".config/alacritty/alacritty.toml"
                              (plain-file "alacritty.toml" alacritty-config))

                        (list ".config/qutebrowser/config.py"
                              (plain-file "qute-config.py" qute-config-py))
                        (list ".config/qutebrowser/qute-home.html"
                              (plain-file "qute-home.html" qute-home-html))
                        (list ".config/qutebrowser/quickmarks"
                              (plain-file "quickmarks" qute-quickmarks))
                        (list ".config/qutebrowser/logo.png"
                              (local-file "stylix/qutebrowser-logo.png"))

                        (list ".config/qutebrowser/userscripts/container-open"
                              (local-file "stylix/qute-userscripts/container-open"))
                        (list ".config/qutebrowser/userscripts/container-add"
                              (local-file "stylix/qute-userscripts/container-add"))
                        (list ".config/qutebrowser/userscripts/container-ls"
                              (local-file "stylix/qute-userscripts/container-ls"))
                        (list ".config/qutebrowser/userscripts/container-rm"
                              (local-file "stylix/qute-userscripts/container-rm"))
                        (list ".config/qutebrowser/userscripts/containers_config"
                              (local-file "stylix/qute-userscripts/containers_config"))
                        (list ".config/qutebrowser/containers"
                              (plain-file "qute-containers" qute-containers))

                        (list ".browser/Gamedev/config/qute-home.html"
                              (plain-file "qute-home-gamedev.html" qute-home-gamedev))
                        (list ".browser/Gamedev/config/logo.png"
                              (local-file "stylix/qutebrowser-logo.png"))
                        (list ".browser/Teaching/config/qute-home.html"
                              (plain-file "qute-home-teaching.html" qute-home-teaching))
                        (list ".browser/Teaching/config/logo.png"
                              (local-file "stylix/qutebrowser-logo.png"))
                        (list ".browser/Youtube/config/qute-home.html"
                              (plain-file "qute-home-youtube.html" qute-home-youtube))
                        (list ".browser/Youtube/config/logo.png"
                              (local-file "stylix/qutebrowser-logo.png"))

                        (list ".config/yazi/yazi.toml"
                              (plain-file "yazi.toml" yazi-toml))
                        (list ".config/yazi/keymap.toml"
                              (plain-file "yazi-keymap.toml" keymap-toml))
                        (list ".config/yazi/theme.toml"
                              (plain-file "yazi-theme.toml" theme-toml))
                        (list ".config/yazi/init.lua"
                              (plain-file "yazi-init.lua" init-lua))
                        (list ".config/yazi/plugins/git.yazi/main.lua"
                              (local-file "stylix/yazi-plugins/git.yazi/main.lua"))
                        (list ".config/yazi/plugins/git.yazi/types.lua"
                              (local-file "stylix/yazi-plugins/git.yazi/types.lua"))
                        (list ".config/yazi/plugins/piper.yazi/main.lua"
                              (local-file "stylix/yazi-plugins/piper.yazi/main.lua"))
                        (list ".config/yazi/plugins/sudo.yazi/main.lua"
                              (local-file "stylix/yazi-plugins/sudo.yazi/main.lua"))
                        (list ".config/yazi/plugins/sudo.yazi/assets/fs.nu"
                              (local-file "stylix/yazi-plugins/sudo.yazi/assets/fs.nu"))
                        (list ".config/yazi/plugins/sudo.yazi/LICENSE"
                              (local-file "stylix/yazi-plugins/sudo.yazi/LICENSE"))
                        (list ".config/yazi/plugins/yatline.yazi/main.lua"
                              (local-file "stylix/yazi-plugins/yatline.yazi/main.lua"))
                        (list ".config/yazi/plugins/yatline.yazi/LICENSE"
                              (local-file "stylix/yazi-plugins/yatline.yazi/LICENSE"))

                        (list ".config/xdg-desktop-portal-termfilechooser/config"
                              (plain-file "termfilechooser-config"
                                (string-append
                                  "[filechooser]\n"
                                  "cmd=/home/noname/.guix-home/profile/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh\n"
                                  "open_mode=suggested\nsave_mode=suggested\n")))

                        (list ".config/gtk-3.0/settings.ini"
                              (plain-file "gtk-3.0-settings.ini" gtk-settings-ini))
                        (list ".config/gtk-3.0/gtk.css"
                              (plain-file "gtk-3.0-gtk.css" gtk-css))


                        (list ".config/qt5ct/qt5ct.conf"
                              (local-file "stylix/qt5ct.conf"))
                        (list ".config/qt6ct/qt6ct.conf"
                              (local-file "stylix/qt6ct.conf"))
                        (list ".config/Trolltech.conf"
                              (local-file "stylix/Trolltech.conf"))
                        (list ".config/kdeglobals"
                              (local-file "stylix/kdeglobals"))

                        (list ".config/vesktop/themes/atelier-lakeside.css"
                              (local-file "stylix/vesktop-theme.css"))
                      ))))))
(nvidia-transform %Anyone)
