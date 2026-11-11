(define-module (anydesk)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages pciutils)
  #:use-module (gnu packages polkit)
  #:use-module (gnu packages xorg)
  #:use-module (guix build-system trivial)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (nonguix build-system binary)
  #:use-module (nonguix licenses))

(define lsb-release-script
  "#!/bin/sh
ID=\"Guix\"
DESC=\"GNU Guix System\"
REL=\"1.5.0\"
CODENAME=\"\"

field_id()      { printf 'Distributor ID:\\t%s\\n' \"$ID\"; }
field_desc()    { printf 'Description:\\t%s\\n' \"$DESC\"; }
field_rel()     { printf 'Release:\\t%s\\n' \"$REL\"; }
field_codename(){ printf 'Codename:\\t%s\\n' \"$CODENAME\"; }

show_all() {
  field_id; field_desc; field_rel; field_codename
}

if [ $# -eq 0 ]; then
  show_all
  exit 0
fi

matched=0
for arg in \"$@\"; do
  case \"$arg\" in
    -a|--all)         matched=1; show_all ;;
    -d|--description) matched=1; field_desc ;;
    -i|--id)          matched=1; field_id ;;
    -r|--release)     matched=1; field_rel ;;
    -c|--codename)    matched=1; field_codename ;;
    -s|--short)       matched=1; printf '%s\\n' \"$CODENAME\" ;;
    -u|--ubuntu)      matched=1 ;;
    --help)           echo 'usage: lsb_release [OPTION]'; exit 0 ;;
    --version)        echo 'lsb_release 1.0'; exit 0 ;;
    -*)               matched=1 ;;
  esac
done

[ \"$matched\" -eq 0 ] && show_all
exit 0
")

(define-public lsb-release
  (package
   (name "lsb-release")
   (version "1.0")
   (source #f)
   (build-system trivial-build-system)
   (arguments
    (list #:modules '((guix build utils))
          #:builder
          #~(begin
              (use-modules (guix build utils))
              (let ((out #$output)
                    (script #$lsb-release-script))
                (mkdir-p (string-append out "/bin"))
                (call-with-output-file
                    (string-append out "/bin/lsb_release")
                  (lambda (port) (display script port)))
                (chmod (string-append out "/bin/lsb_release") #o755)))))
   (synopsis "Minimal lsb_release shim")
   (description "Provides a minimal lsb_release implementation for programs
that probe the distribution (e.g. AnyDesk).")
   (license #f)
   (home-page #f)))

(define-public anydesk
  (package
    (name "anydesk")
    (version "8.1.0")
    (source (origin
              (method url-fetch)
              (uri (string-append "https://download.anydesk.com/linux/anydesk-"
                                  version "-amd64.tar.gz"))
              (sha256
               (base32
                "117cmsz0bdwinr9rcmbxrifjbkg8j06rkg0mf0xrc7ckxkclybnd"))))
    (build-system binary-build-system)
    (arguments
     `(#:validate-runpath? #f
       #:strip-binaries? #f
       #:patchelf-plan
       `(("anydesk"
          ("atk"
           "cairo"
           "dbus"
           "eudev"
           "fontconfig"
           "gcc:lib"
           "gdk-pixbuf"
           "glib"
           "gtk+"
           "libepoxy"
           "libevdev"
           "libx11"
           "libxcb"
           "libxdamage"
           "libxext"
           "libxfixes"
           "libxi"
           "libxkbfile"
           "libxrandr"
           "libxrender"
           "libxtst"
           "pango"
           "polkit"
           "wayland"
           "zlib")))
       #:install-plan
       `(("anydesk" "bin/anydesk")
         ("anydesk.desktop" "share/applications/anydesk.desktop")
         ("icons/" "share/icons/")
         ("polkit-1/" "etc/polkit-1/actions/")
         ("copyright" "share/doc/anydesk/copyright")
         ("README" "share/doc/anydesk/README"))
       #:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'fix-desktop-file
           (lambda* (#:key outputs #:allow-other-keys)
             (let ((out (assoc-ref outputs "out")))
               (substitute* "anydesk.desktop"
                 (("^Exec=.*")
                  (string-append "Exec=" out "/bin/anydesk %u\n"))
                 (("^Icon=.*") "Icon=anydesk\n")))))
         (add-after 'install 'wrap-program
           (lambda* (#:key outputs #:allow-other-keys)
             (let ((out (assoc-ref outputs "out")))
               (wrap-program (string-append out "/bin/anydesk")
                 (list "PATH" 'prefix
                       (map (lambda (input)
                              (string-append
                               (assoc-ref %build-inputs input) "/bin"))
                            '("lsb-release" "pciutils" "net-tools")))
                 '("GDK_BACKEND" = ("x11"))
                 '("GTK_THEME" = ("Adwaita")))))))))
    (inputs
     `(("atk" ,at-spi2-core)
       ("cairo" ,cairo)
       ("dbus" ,dbus)
       ("eudev" ,eudev)
       ("fontconfig" ,fontconfig)
       ("gcc:lib" ,gcc "lib")
       ("gdk-pixbuf" ,gdk-pixbuf)
       ("glib" ,glib)
       ("gtk+" ,gtk+)
       ("libepoxy" ,libepoxy)
       ("libevdev" ,libevdev)
       ("libx11" ,libx11)
       ("libxcb" ,libxcb)
       ("libxdamage" ,libxdamage)
       ("libxext" ,libxext)
       ("libxfixes" ,libxfixes)
       ("libxi" ,libxi)
       ("libxkbfile" ,libxkbfile)
       ("libxrandr" ,libxrandr)
       ("libxrender" ,libxrender)
       ("libxtst" ,libxtst)
       ("lsb-release" ,lsb-release)
       ("net-tools" ,net-tools)
       ("pciutils" ,pciutils)
       ("pango" ,pango)
       ("polkit" ,polkit)
       ("wayland" ,wayland)
       ("zlib" ,zlib)))
    (synopsis  "Remote desktop software")
    (supported-systems '("x86_64-linux"))
    (description "Connect to a computer remotely, be it from the other end of
the office or halfway around the world.  AnyDesk ensures secure and reliable
remote desktop connections for IT professionals and on-the-go individuals alike.")
    (home-page "https://anydesk.com/")
    (license (nonfree "https://anydesk.com/en/terms"))))

anydesk
