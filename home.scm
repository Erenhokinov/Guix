(add-to-load-path "/home/lix/guix/packages")
(use-modules (gnu home)
             (gnu home services)
             (guix gexp)
	     (nonguix transformations)
             (prism_pkg)
             (gnu packages freedesktop)
             (vesktop_pkg)
	     (nongnu packages nvidia)
             (guix packages)
             (nongnu packages game-client)
             (nonguix multiarch-container))
(define nvidia-transform (nonguix-transformation-nvidia #:driver nvda-595))
(define %Anyone
(home-environment
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
           (@ (gnu packages polkit) polkit-gnome)
           (@ (gnu packages xfce) thunar)
           (@ (gnu packages linux) brightnessctl)
           (@ (gnu packages linux) wireplumber)
           (@ (gnu packages fonts) font-jetbrains-mono)
           (@ (gnu packages fonts) font-nerd-symbols)
           (@ (gnu packages xorg) xcursor-themes)
           (@ (gnu packages telegram) telegram-desktop)
           (@ (nongnu packages editors) vscodium)
           (@ (nongnu packages game-client) steam)
           prism-cracked
           vesktop))   

  (services
    (list
      (simple-service 'qt-wayland-env
                      home-environment-variables-service-type
                      '(("QT_QPA_PLATFORM" . "wayland;xcb")))

      (simple-service 'dotfiles
                      home-files-service-type
                      (list
                        (list ".config/waybar/config.jsonc"
                              (local-file "dotfiles/waybar/config.jsonc"))

                        (list ".config/waybar/style.css"
                              (local-file "dotfiles/waybar/style.css"))

                        (list ".config/hypr/hyprland.lua"
                              (local-file "dotfiles/hypr/hyprland.lua"))

                        (list ".config/hypr/hyprpaper.conf"
                              (local-file "dotfiles/hypr/hyprpaper.conf"))

                        (list ".config/hypr/shaders/vibrance.frag"
                              (local-file "dotfiles/hypr/shaders/vibrance.frag"))

                        (list ".config/gtk-3.0/settings.ini"
                              (local-file "dotfiles/gtk-3.0/settings.ini"))
                      ))))))
(nvidia-transform %Anyone)
