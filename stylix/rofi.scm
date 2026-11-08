(define-module (stylix rofi)
  ;;rofi

  #:export (rofi-theme-rasi rofi-config-rasi))

(use-modules (stylix theme) (srfi srfi-11))

(define (rgba90 name)
  (let-values (((r g b) (rgb-of name)))
    (format #f "rgba(~a,~a,~a,90%)" r g b)))

(define (rgb name)
  (let-values (((r g b) (rgb-of name)))
    (format #f "~a,~a,~a" r g b)))

(define rofi-theme-rasi
  (string-append
   "* {\n"
   "  background: " (rgba90 "base00") ";\n"
   "  lightbg: " (rgba90 "base01") ";\n"
   "  red: " (rgba90 "base08") ";\n"
   "  blue: " (rgba90 "base13") ";\n"
   "  lightfg: " (rgba90 "base06") ";\n"
   "  foreground: " (rgba90 "base05") ";\n"
   "  background-color: rgb(" (rgb "base00") ");\n"
   "  separatorcolor: @foreground;\n"
   "  border-color: @foreground;\n"
   "  selected-normal-foreground: @lightbg;\n"
   "  selected-normal-background: @lightfg;\n"
   "  selected-active-foreground: @background;\n"
   "  selected-active-background: @blue;\n"
   "  selected-urgent-foreground: @background;\n"
   "  selected-urgent-background: @red;\n"
   "  normal-foreground: @foreground;\n"
   "  normal-background: @background;\n"
   "  active-foreground: @blue;\n"
   "  active-background: @background;\n"
   "  urgent-foreground: @red;\n"
   "  urgent-background: @background;\n"
   "  alternate-normal-foreground: @foreground;\n"
   "  alternate-normal-background: @lightbg;\n"
   "  alternate-active-foreground: @blue;\n"
   "  alternate-active-background: @lightbg;\n"
   "  alternate-urgent-foreground: @red;\n"
   "  alternate-urgent-background: @lightbg;\n"
   "  base-text: rgb(" (rgb "base05") ");\n"
   "  selected-normal-text: rgb(" (rgb "base01") ");\n"
   "  selected-active-text: rgb(" (rgb "base00") ");\n"
   "  selected-urgent-text: rgb(" (rgb "base00") ");\n"
   "  normal-text: rgb(" (rgb "base05") ");\n"
   "  active-text: rgb(" (rgb "base13") ");\n"
   "  urgent-text: rgb(" (rgb "base08") ");\n"
   "  alternate-normal-text: rgb(" (rgb "base05") ");\n"
   "  alternate-active-text: rgb(" (rgb "base13") ");\n"
   "  alternate-urgent-text: rgb(" (rgb "base08") ");\n"
   "}\n\n"

   "window { background-color: @background; }\n"
   "message { border-color: @separatorcolor; }\n"
   "textbox { text-color: @base-text; }\n"
   "listview { border-color: @separatorcolor; }\n"
   "element-text { background-color: inherit; text-color: inherit; }\n"
   "element-icon { background-color: inherit; text-color: inherit; }\n"
   "element normal.normal { background-color: @normal-background; text-color: @normal-text; }\n"
   "element normal.urgent { background-color: @urgent-background; text-color: @urgent-text; }\n"
   "element normal.active { background-color: @active-background; text-color: @active-text; }\n"
   "element selected.normal { background-color: @selected-normal-background; text-color: @selected-normal-text; }\n"
   "element selected.urgent { background-color: @selected-urgent-background; text-color: @selected-urgent-text; }\n"
   "element selected.active { background-color: @selected-active-background; text-color: @selected-active-text; }\n"
   "element alternate.normal { background-color: @alternate-normal-background; text-color: @alternate-normal-text; }\n"
   "element alternate.urgent { background-color: @alternate-urgent-background; text-color: @alternate-urgent-text; }\n"
   "element alternate.active { background-color: @alternate-active-background; text-color: @alternate-active-text; }\n\n"

   "scrollbar { handle-color: @normal-foreground; }\n"
   "sidebar { border-color: @separatorcolor; }\n"
   "button { text-color: @normal-text; }\n"
   "button selected { background-color: @selected-normal-background; text-color: @selected-normal-text; }\n"
   "inputbar { text-color: @normal-text; }\n"
   "case-indicator { text-color: @normal-text; }\n"
   "entry { text-color: @normal-text; }\n"
   "prompt { text-color: @normal-text; }\n"
   "textbox-prompt-colon { text-color: inherit; }\n"))

(define rofi-config-rasi
  (string-append
   "@theme \"~/.config/rofi/theme.rasi\"\n"
   "font: \"JetBrains Mono NL 12\";\n"
   "show-icons: true;\n"
   "sidebar-mode: left;\n"
   "display-combi: false;\n"))
