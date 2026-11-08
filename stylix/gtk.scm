(define-module (stylix gtk)
  ;;gtk

  #:export (gtk-css gtk-settings-ini))

(use-modules (srfi srfi-11) (stylix theme))

(define (dec name)
  (let-values (((r g b) (rgb-of name)))
    (format #f "~a, ~a, ~a" r g b)))

(define (defcolor name prop hex)
  (format #f "@define-color ~a ~a;\n" prop hex))

(define gtk-css
  (string-append
   (defcolor "x" "accent_color" (hx "base13"))
   (defcolor "x" "accent_bg_color" (hx "base13"))
   (format #f "@define-color accent_fg_color ~a;\n" (hx "base00"))
   (defcolor "x" "destructive_color" (hx "base08"))
   (defcolor "x" "destructive_bg_color" (hx "base08"))
   (format #f "@define-color destructive_fg_color ~a;\n" (hx "base00"))
   (defcolor "x" "success_color" (hx "base11"))
   (defcolor "x" "success_bg_color" (hx "base11"))
   (format #f "@define-color success_fg_color ~a;\n" (hx "base00"))
   (defcolor "x" "warning_color" (hx "base14"))
   (defcolor "x" "warning_bg_color" (hx "base14"))
   (format #f "@define-color warning_fg_color ~a;\n" (hx "base00"))
   (defcolor "x" "error_color" (hx "base08"))
   (defcolor "x" "error_bg_color" (hx "base08"))
   (format #f "@define-color error_fg_color ~a;\n" (hx "base00"))
   (format #f "@define-color window_bg_color ~a;\n" (hx "base00"))
   (format #f "@define-color window_fg_color ~a;\n" (hx "base05"))
   (format #f "@define-color view_bg_color ~a;\n" (hx "base00"))
   (format #f "@define-color view_fg_color ~a;\n" (hx "base05"))
   (format #f "@define-color headerbar_bg_color ~a;\n" (hx "base01"))
   (format #f "@define-color headerbar_fg_color ~a;\n" (hx "base05"))
   (format #f "@define-color headerbar_border_color rgba(~a, 0.7);\n" (dec "base01"))
   "@define-color headerbar_backdrop_color @window_bg_color;\n"
   "@define-color headerbar_shade_color rgba(0, 0, 0, 0.07);\n"
   "@define-color headerbar_darker_shade_color rgba(0, 0, 0, 0.07);\n"
   (format #f "@define-color sidebar_bg_color ~a;\n" (hx "base01"))
   (format #f "@define-color sidebar_fg_color ~a;\n" (hx "base05"))
   "@define-color sidebar_backdrop_color @window_bg_color;\n"
   "@define-color sidebar_shade_color rgba(0, 0, 0, 0.07);\n"
   "@define-color secondary_sidebar_bg_color @sidebar_bg_color;\n"
   "@define-color secondary_sidebar_fg_color @sidebar_fg_color;\n"
   "@define-color secondary_sidebar_backdrop_color @sidebar_backdrop_color;\n"
   "@define-color secondary_sidebar_shade_color @sidebar_shade_color;\n"
   (format #f "@define-color card_bg_color ~a;\n" (hx "base01"))
   (format #f "@define-color card_fg_color ~a;\n" (hx "base05"))
   "@define-color card_shade_color rgba(0, 0, 0, 0.07);\n"
   (format #f "@define-color dialog_bg_color ~a;\n" (hx "base01"))
   (format #f "@define-color dialog_fg_color ~a;\n" (hx "base05"))
   (format #f "@define-color popover_bg_color ~a;\n" (hx "base01"))
   (format #f "@define-color popover_fg_color ~a;\n" (hx "base05"))
   "@define-color popover_shade_color rgba(0, 0, 0, 0.07);\n"
   "@define-color shade_color rgba(0, 0, 0, 0.07);\n"
   (format #f "@define-color scrollbar_outline_color ~a;\n" (hx "base02"))
   (let loop ((i 1) (acc ""))
     (if (> i 5)
         acc
         (loop (+ i 1)
               (string-append
                acc
                (format #f "@define-color blue_~a ~a;\n" i (hx "base13"))
                (format #f "@define-color green_~a ~a;\n" i (hx "base11"))
                (format #f "@define-color yellow_~a ~a;\n" i (hx "base10"))
                (format #f "@define-color orange_~a ~a;\n" i (hx "base09"))
                (format #f "@define-color red_~a ~a;\n" i (hx "base08"))
                (format #f "@define-color purple_~a ~a;\n" i (hx "base14"))
                (format #f "@define-color brown_~a ~a;\n" i (hx "base15"))
                (format #f "@define-color light_~a ~a;\n" i (hx "base05"))
                (format #f "@define-color dark_~a ~a;\n" i (hx "base05"))))))
   "window, .background { background-color: @window_bg_color; color: @window_fg_color; }\n"
   "headerbar { background-color: @headerbar_bg_color; color: @headerbar_fg_color; }\n"
   "headerbar:backdrop { background-color: @headerbar_backdrop_color; }\n"
   "sidebar, .sidebar { background-color: @sidebar_bg_color; color: @sidebar_fg_color; }\n"
   "card, .card { background-color: @card_bg_color; color: @card_fg_color; }\n"
   "dialog, popover { background-color: @popover_bg_color; color: @popover_fg_color; }\n"
   "selection { background-color: @accent_bg_color; color: @accent_fg_color; }\n"
   "button.suggested-action, button.image-button.suggested-action {\n"
   "  background-color: @accent_bg_color;\n"
   "  color: @accent_fg_color;\n"
   "}\n"
   "button.destructive-action, button.image-button.destructive-action {\n"
   "  background-color: @destructive_bg_color;\n"
   "  color: @destructive_fg_color;\n"
   "}\n"
   "scrollbar slider { background-color: @scrollbar_outline_color; }\n"
   "scrollbar slider:hover { background-color: @accent_bg_color; }\n"
   "scrollbar slider:active { background-color: @accent_bg_color; }\n"))

(define gtk-settings-ini
  (string-append
   "[Settings]\n"
   "gtk-decoration-layout=:\n"
   "gtk-cursor-theme-name=whiteglass\n"
   "gtk-cursor-theme-size=24\n"))
