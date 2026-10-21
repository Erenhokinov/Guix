(add-to-load-path "/root/.config/guix/packages")
(use-modules (gnu)
             (gnu services pm)
	     (prism_pkg)
	     (gnu packages xfce)
	     (gnu packages glib)
	     (nongnu packages editors)
	     (nongnu packages game-client)
	     (vesktop_pkg)
	     (gnu packages package-management)
             (gnu services sysctl)
	     (gnu services base)
	     (gnu system accounts)
             (gnu system nss)
             (nonguix transformations)
	     (nonguix multiarch-container)
             (nongnu packages linux)
             (nongnu packages nvidia)
             (nongnu system linux-initrd))

(use-service-modules dbus linux desktop networking ssh pm cups)

(use-package-modules gnome telegram xorg wm freedesktop bootloaders polkit xdisorg gl vulkan
                      web-browsers vim text-editors fonts python-xyz
                      terminals version-control)

(define nvidia-transform
  (nonguix-transformation-nvidia
   #:driver nvda-new-feature))

(define %my-os
  (operating-system
    (kernel linux)
    (firmware (list linux-firmware))
    (initrd microcode-initrd)
    (host-name "gnu")
    (timezone "Europe/Moscow")
    (locale "en_US.utf8")

    (bootloader (bootloader-configuration
                 (bootloader grub-efi-bootloader)
                 (targets '("/boot/efi"))))

    (file-systems
     (append
      (list (file-system
             (device "/dev/nvme0n1p6")
             (mount-point "/")
             (type "ext4"))
            (file-system
             (device "/dev/nvme0n1p3")
             (mount-point "/boot/efi")
             (type "vfat")))
      %base-file-systems))

    (users
     (cons (user-account
            (name "lix")
            (group "users")
            (supplementary-groups '("wheel" "netdev" "input" "audio" "video")))
           %base-user-accounts))

    (packages
     (append
      (list
            xdg-desktop-portal
            xdg-desktop-portal-hyprland
            polkit-gnome
            mesa
            vulkan-loader
	    telegram-desktop
	    ydotool
            nvidia-prime           
	    prism-cracked
	    (@ (gnu packages window-management) waybar)
	    (@ (gnu packages window-management) hyprland)
	    font-nerd-symbols
	    hyprpaper
	    thunar
	    vesktop
	    vscodium
	    flatpak
	    alacritty
	    xcursor-themes
	    steam
            network-manager
	    dbus
            qutebrowser
            neovim
            rofi
            git
            font-jetbrains-mono)
      %base-packages))

    (services
     (append
      (list (service dbus-root-service-type)
	     (service zram-device-service-type
  	    (zram-device-configuration
  	    (size "4G")
            (compression-algorithm 'lz4)
   	    (priority 100)))
            (service wpa-supplicant-service-type)
            (service network-manager-service-type)
            (service elogind-service-type)
	    (udev-rules-service
 	    'uinput
 	    (file->udev-rule
  	    "99-uinput.rules"
  	    (plain-file "99-uinput.rules"
              "KERNEL==\"uinput\", GROUP=\"input\", MODE=\"0660\", OPTIONS+=\"static_node=uinput\"\n"))
 	    #:groups '("input"))
            (service polkit-service-type))
      (modify-services %base-services
        (guix-service-type config =>
          (guix-configuration
           (inherit config)
           (substitute-urls
            (append (list "https://substitutes.nonguix.org")
                    %default-substitute-urls))
           (authorized-keys
            (append (list (local-file "/etc/guix/signing-key.pub"))
                    %default-authorized-guix-keys)))))))))

(nvidia-transform %my-os)
