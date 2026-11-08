(define-module (stylix alacritty)
  ;;alacritty

  #:export (alacritty-config))

(use-modules (stylix theme))

(define (kv section key color)
  (format #f "  ~a = \"~a\"\n" key (hx color)))

(define alacritty-config
  (string-append
   "[font]\n"
   "  size = 13\n"
   "  normal = { family = \"JetBrains Mono NL\", style = \"Regular\" }\n\n"
   "[window]\n"
   "  opacity = 0.9\n"
   "  padding = { x = 8, y = 6 }\n"
   "  decorations = \"Buttonless\"\n\n"
   "[bell]\n"
   "  animation = \"Linear\"\n"
   "  command = \"\"\n"
   "  duration = 100\n"
   (format #f "  color = \"~a\"\n\n" (hx "base08"))
   "[colors.primary]\n"
   (format #f "  background = \"~a\"\n" (hx "base00"))
   (format #f "  foreground = \"~a\"\n" (hx "base05"))
   (format #f "  bright_foreground = \"~a\"\n\n" (hx "base07"))
   "[colors.cursor]\n"
   (kv "x" "text" "base00")
   (format #f "  cursor = \"~a\"\n\n" (hx "base05"))
   "[colors.vi_mode_cursor]\n"
   (kv "x" "text" "base00")
   (format #f "  cursor = \"~a\"\n\n" (hx "base08"))
   "[colors.search.matches]\n"
   (kv "x" "foreground" "base00")
   (format #f "  background = \"~a\"\n\n" (hx "base10"))
   "[colors.hints]\n"
   (format #f "  start = { foreground = \"~a\", background = \"~a\" }\n" (hx "base00") (hx "base11"))
   (format #f "  end = { foreground = \"~a\", background = \"~a\" }\n\n" (hx "base00") (hx "base12"))
   "[colors.selection]\n"
   (kv "x" "text" "base05")
   (format #f "  background = \"~a\"\n\n" (hx "base02"))
   "[colors.footer_bar]\n"
   (kv "x" "foreground" "base05")
   (format #f "  background = \"~a\"\n\n" (hx "base01"))
   "[colors.normal]\n"
   (format #f "  black = \"~a\"\n" (hx "base00"))
   (format #f "  red = \"~a\"\n" (hx "base08"))
   (format #f "  green = \"~a\"\n" (hx "base11"))
   (format #f "  yellow = \"~a\"\n" (hx "base10"))
   (format #f "  blue = \"~a\"\n" (hx "base13"))
   (format #f "  magenta = \"~a\"\n" (hx "base14"))
   (format #f "  cyan = \"~a\"\n" (hx "base12"))
   (format #f "  white = \"~a\"\n\n" (hx "base05"))
   "[colors.bright]\n"
   (format #f "  black = \"~a\"\n" (hx "base03"))
   (format #f "  red = \"~a\"\n" (brightness (hx "base08") 1.15))
   (format #f "  green = \"~a\"\n" (brightness (hx "base11") 1.15))
   (format #f "  yellow = \"~a\"\n" (brightness (hx "base10") 1.15))
   (format #f "  blue = \"~a\"\n" (brightness (hx "base13") 1.15))
   (format #f "  magenta = \"~a\"\n" (brightness (hx "base14") 1.15))
   (format #f "  cyan = \"~a\"\n" (brightness (hx "base12") 1.15))
   (format #f "  white = \"~a\"\n\n" (hx "base07"))
   "[colors.dim]\n"
   (format #f "  black = \"~a\"\n" (hx "base01"))
   (format #f "  red = \"~a\"\n" (hx "base08"))
   (format #f "  green = \"~a\"\n" (hx "base11"))
   (format #f "  yellow = \"~a\"\n" (hx "base10"))
   (format #f "  blue = \"~a\"\n" (hx "base13"))
   (format #f "  magenta = \"~a\"\n" (hx "base14"))
   (format #f "  cyan = \"~a\"\n" (hx "base12"))
   (format #f "  white = \"~a\"\n" (hx "base04"))
   ))
