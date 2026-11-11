(use-modules (guix build-system trivial)
             (guix gexp)
             (guix packages))

(define script
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
                  (script #$script))
              (mkdir-p (string-append out "/bin"))
              (call-with-output-file
                  (string-append out "/bin/lsb_release")
                (lambda (port) (display script port)))
              (chmod (string-append out "/bin/lsb_release") #o755)))))
 (synopsis "Minimal lsb_release shim")
 (description "Provides a minimal lsb_release implementation for programs
that probe the distribution (e.g. AnyDesk).")
 (license #f)
 (home-page #f))
