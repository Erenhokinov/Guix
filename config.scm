(use-modules (gnu)
             (srfi srfi-1)
             (gnu services pm)
             (gnu services sysctl)
             (gnu services shepherd)
	           (gnu services base)
	           (gnu system accounts)
             (gnu system nss)
            (guix download)
          (guix packages)
	     (gnu packages glib)
	     (gnu packages linux)
             (gnu packages shells)
             (nonguix transformations)
             (nongnu packages linux)
             (nongnu packages nvidia)
             (nongnu system linux-initrd))

(use-service-modules dbus linux desktop networking ssh pm cups)
(use-package-modules gnome bootloaders xdisorg polkit gl package-management vulkan python-xyz)

(define nvidia-transform
  (nonguix-transformation-nvidia
   #:driver nvda-620))

(define %my-os
  (operating-system
    (kernel linux)
    (firmware (list linux-firmware))
    (initrd microcode-initrd)
    (host-name "nyarch")
    (timezone "Europe/Kyiv")
    (locale "en_US.utf8")

    (bootloader (bootloader-configuration
                 (bootloader grub-efi-bootloader)
                 (targets '("/boot"))))

    (file-systems
     (append
      (list (file-system
             (device "/dev/nvme0n1p7")
             (mount-point "/")
             (type "ext4"))
            (file-system
             (device "/dev/nvme0n1p4")
             (mount-point "/boot")
             (type "vfat")))
      %base-file-systems))

    (users
     (cons (user-account
            (name "noname")
            (group "users")
            (supplementary-groups '("wheel" "netdev" "input" "audio" "video"))
            (shell #~(string-append #$zsh "/bin/zsh")))
           %base-user-accounts))

    ;;packages
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
      zsh
	    dbus)
      (remove (lambda (package)
                (member (package-name package)
                        '("nano" "mg" "nvi" "wireless-tools"
                          "kbd" "lzip" "info-reader")))
              %base-packages)))

    ;;services
    (services
     (append
      (list (service dbus-root-service-type)
	     (service zram-device-service-type
  	    (zram-device-configuration
  	    (size "4G")
            (compression-algorithm 'zstd)
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
            (service polkit-service-type)
            (simple-service 'ryzenadj-power-limits
              shepherd-root-service-type
              (list
               (shepherd-service
                (provision '(ryzenadj-power-limits))
                (documentation "Cap Ryzen SMU power limits: 18W sustained, 21W boost.")
                (requirement '(file-systems))
                (one-shot? #t)
                (respawn? #f)
                (start #~(lambda ()
                           (system* #$(file-append ryzenadj "/bin/ryzenadj")
                                    "--stapm-limit=18000"
                                    "--fast-limit=21000"
                                    "--slow-limit=21000"
                                    "--apu-slow-limit=21000")
                           ;; keep boost on, cap all cores at 3.4GHz
                           (call-with-output-file
                            "/sys/devices/system/cpu/cpufreq/boost"
                            (lambda (port) (display "1" port)))
                           (for-each
                            (lambda (cpu)
                              (let ((dir (string-append
                                          "/sys/devices/system/cpu/"
                                          cpu "/cpufreq")))
                                (when (file-exists? (string-append dir
                                                                   "/scaling_max_freq"))
                                  (call-with-output-file
                                   (string-append dir "/scaling_max_freq")
                                   (lambda (port) (display "3400000" port))))))
                            '("cpu0" "cpu1" "cpu2" "cpu3" "cpu4" "cpu5"
                              "cpu6" "cpu7" "cpu8" "cpu9" "cpu10" "cpu11"))
                           #t))))))
      (modify-services %base-services
        (guix-service-type config =>
          (guix-configuration
           (inherit config)
           (substitute-urls
            (append (list "https://substitutes.nonguix.org"
                          "https://guix.bordeaux.inria.fr")
                    %default-substitute-urls))
(authorized-keys
 (append (list (origin
                 (method url-fetch)
                 (uri "https://substitutes.nonguix.org/signing-key.pub")
                 (file-name "nonguix.pub")
                 (sha256
                  (base32 "0j66nq1bxvbxf5n8q2py14sjbkn57my0mjwq7k1qm9ddghca7177")))
               (plain-file "guix-science.pub"
                           "(public-key (ecc (curve Ed25519) (q #89FBA276A976A8DE2A69774771A92C8C879E0F24614AAAAE23119608707B3F06#)))"))
         %default-authorized-guix-keys)))))))))

(nvidia-transform %my-os)
