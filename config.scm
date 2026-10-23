(use-modules (gnu)
             (gnu services pm)
             (gnu services sysctl)
	           (gnu services base)
	           (gnu system accounts)
             (gnu system nss)
             (nonguix transformations)
             (nongnu packages linux)
             (nongnu packages nvidia)
             (nongnu system linux-initrd))

(use-service-modules dbus linux desktop networking ssh pm cups)
(use-package-modules gnome bootloaders xdisorg polkit gl package-management vulkan python-xyz)

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
      polkit-gnome
      mesa
      vulkan-loader
      flatpak
      ydotool
      nvidia-prime           
      network-manager
	    dbus)
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
