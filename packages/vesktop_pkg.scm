(define-module (vesktop_pkg)
  #:use-module (guix packages)
  #:use-module (gnu packages)
  #:use-module ((guix licenses))
  #:use-module (guix download)
  #:use-module (nonguix build-system chromium-binary)
  #:use-module (nonguix multiarch-container)
  #:use-module (guix gexp)
  #:use-module (gnu packages pulseaudio)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages glib)
)
;;vesktop

(define vesktop-client-libs
  `(
    ("pulseaudio", pulseaudio)
    ("dbus-glib", dbus-glib)
  )
)

(define-public vesktop-client
  (package
    (name "vesktop-client")
    (version "1.6.7") 
    (source
      (origin
        (method url-fetch)
	(uri
	  (string-append
	    "https://github.com/Vencord/Vesktop/releases/download/v" version "/vesktop_" version "_amd64.deb"
	  )
	)
	(file-name (string-append "vesktop_" version "_amd64.deb"))
	(sha256
	  (base32
	    "0qbaxaz3kzkwv9pnnxlq8rnwlb9x89qbxabjpzg127c6z3ya6102" 
	  )
	)
      )
    )
    (build-system chromium-binary-build-system)
    (arguments
      (list
        #:validate-runpath? #f 
           #:wrapper-plan
           #~(map 
             (lambda (file)
               (string-append "lib/Vesktop/" file)   
             )
             '(
               "vesktop"
               "chrome-sandbox"
               "chrome_crashpad_handler"
               "libEGL.so"
               "libffmpeg.so"
               "libGLESv2.so"
               "libvk_swiftshader.so"
               "libvulkan.so.1"
             )
           )
           #:phases
             #~(modify-phases %standard-phases
               (add-after 'binary-unpack 'setup-cwd
                 (lambda _
                   (copy-recursively "usr/" ".")
                   (rename-file "opt/" "lib")
                   (delete-file-recursively "usr")
                 )
               )
               (add-after 'patch-dot-desktop-files 'fix-desktop-file
                 (lambda _
                   (substitute*
                     (string-append #$output "/share/applications/vesktop.desktop")
                     (("Exec=.*/vesktop") "Exec=vesktop --disable-gpu-compositing")
                   )
                 )
               )
            (delete 'patch-dot-desktop-files)
                         (add-after 'install 'symlink-binary-file
                 (lambda _
                   (mkdir-p (string-append #$output "/bin"))
                   (symlink
                     (string-append #$output "/lib/Vesktop/vesktop")
                     (string-append #$output "/bin/vesktop")
                   )
                   (for-each
                     (lambda (lib)
                       (symlink
                         (string-append #$output "/lib/Vesktop/" lib)
                         (string-append #$output "/" lib)
                       )
                     )
                     '("libffmpeg.so" "libEGL.so" "libGLESv2.so"
                       "libvk_swiftshader.so" "libvulkan.so.1")
                 )
          	)
              )
	    )
           )
          )
    (synopsis "Vesktop is a customizable and privacy friendly Discord desktop app!")
    (description
      "Vesktop is a custom Discord App aiming to give you better performance and improve linux support"
    )
    (home-page "https://vesktop.dev/")
    (license gpl3+)
    (supported-systems '("x86_64-linux"))
  )
)

(define-public (vesktop-container)
  (nonguix-container
    (name "vesktop")
    (wrap-package vesktop-client)
    (run "/bin/vesktop")
    (packages 
      vesktop-client-libs
    )
    (link-files '("share"))
    (description "Vesktop is a discord client. This package provides a script for launching vesktop in a Guix container
which will use the directory @file{$HOME/.local/share/guix-sandbox-home} whereall games will be installed."
    )
  )
)

(define-public vesktop-composer
  (compose nonguix-container->package vesktop-container)
)

(define-public vesktop
  (vesktop-composer)
)
