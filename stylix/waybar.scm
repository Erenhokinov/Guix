(define-module (stylix waybar)
  ;;waybar

  #:export (waybar-config-json waybar-style-css))

(use-modules (srfi srfi-11) (stylix theme))

(define waybar-config-json
  (string-append
   "{\n"
   "  \"layer\": \"top\",\n"
   "  \"position\": \"top\",\n"
   "  \"height\": 30,\n"
   "  \"margin-top\": 0,\n"
   "  \"margin-left\": 0,\n"
   "  \"margin-right\": 0,\n"
   "  \"spacing\": 4,\n\n"
   "  \"modules-left\": [\"hyprland/window\"],\n"
   "  \"modules-center\": [\"hyprland/workspaces\", \"clock\"],\n"
   "  \"modules-right\": [\"pulseaudio\", \"network\", \"cpu\", \"memory\", \"battery\", \"tray\"],\n\n"
   "  \"hyprland/workspaces\": {\n"
   "    \"format\": \"{name}\",\n"
   "    \"all-outputs\": false,\n"
   "    \"on-click\": \"activate\",\n"
   "    \"format-icons\": { \"active\": \"\", \"default\": \"\" }\n"
   "  },\n\n"
   "  \"hyprland/window\": {\n"
   "    \"format\": \"{title}\",\n"
   "    \"max-length\": 40,\n"
   "    \"separate-outputs\": true\n"
   "  },\n\n"
   "  \"clock\": {\n"
   "    \"format\": \"  {:%H:%M}\",\n"
   "    \"format-alt\": \"  {:%A, %d %B %Y}\",\n"
   "    \"tooltip-format\": \"<tt><small>{calendar}</small></tt>\"\n"
   "  },\n\n"
   "  \"cpu\": { \"format\": \"  {usage}%\", \"interval\": 3 },\n\n"
   "  \"memory\": { \"format\": \"  {percentage}%\" },\n\n"
   "  \"battery\": {\n"
   "    \"states\": { \"warning\": 30, \"critical\": 15 },\n"
   "    \"format\": \"{icon}  {capacity}%\",\n"
   "    \"format-charging\": \"  {capacity}%\",\n"
   "    \"format-icons\": [\"\", \"\", \"\", \"\", \"\"]\n"
   "  },\n\n"
   "  \"network\": {\n"
   "    \"format-wifi\": \"  {essid}\",\n"
   "    \"format-ethernet\": \"  Wired\",\n"
   "    \"format-disconnected\": \"  Offline\",\n"
   "    \"tooltip-format\": \"{ifname}: {ipaddr}/{cidr}\"\n"
   "  },\n\n"
   "  \"pulseaudio\": {\n"
   "    \"format\": \"{icon}  {volume}%\",\n"
   "    \"format-muted\": \"  Muted\",\n"
   "    \"format-icons\": { \"default\": [\"\", \"\", \"\"] },\n"
   "    \"on-click\": \"wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle\"\n"
   "  },\n\n"
   "  \"tray\": { \"spacing\": 8 }\n"
   "}\n"))

(define waybar-style-css
  (string-append
   "* {\n"
   "  font-family: \"JetBrains Mono\", \"Symbols Nerd Font\", sans-serif;\n"
   "  font-size: 13px;\n"
   "  border: none;\n"
   "  border-radius: 0;\n"
   "  outline: none;\n"
   "  box-shadow: none;\n"
   "  min-height: 0;\n"
   "}\n\n"
   (let-values (((r g b) (rgb-of "base00")))
     (format #f (string-append
                 "window#waybar {\n"
                 "  background: rgba(~a, ~a, ~a, 0.85);\n"
                 "  border-radius: 0;\n"
                 "  color: ~a;\n"
                 "}\n\n") r g b (hx "base05")))
   "#workspaces {\n"
   "  margin: 4px 6px;\n"
   "}\n"
   "#workspaces button {\n"
   "  padding: 0 8px;\n"
   (format #f "  color: ~a;\n" (hx "base03"))
   "  background: transparent;\n"
   "  border-radius: 0;\n"
   "}\n"
   "#workspaces button.active {\n"
   (format #f "  color: ~a;\n" (hx "base00"))
   (format #f "  background: ~a;\n" (hx "base13"))
   (format #f "  text-shadow: 0 0 8px ~a;\n" (hx "base13"))
   "  box-shadow: 0 0 8px " (hx "base13") ";\n"
   "}\n"
   "#workspaces button.urgent {\n"
   (format #f "  color: ~a;\n" (hx "base00"))
   (format #f "  background: ~a;\n" (hx "base08"))
   "}\n"
   "#workspaces button:hover {\n"
   (format #f "  background: ~a;\n" (hx "base02"))
   (format #f "  color: ~a;\n" (hx "base05"))
   "}\n\n"
   (format #f "#window {\n  color: ~a;\n  padding: 0 8px;\n}\n\n" (hx "base04"))
   (format #f "#clock {\n  color: ~a;\n  font-weight: bold;\n  padding: 0 10px;\n}\n\n" (hx "base06"))
   "#cpu, #memory, #battery, #network, #pulseaudio, #tray {\n"
   "  padding: 0 10px;\n"
   "  margin: 0 2px;\n"
   (format #f "  color: ~a;\n" (hx "base05"))
   "}\n\n"
   (format #f "#battery.warning { color: ~a; }\n" (hx "base09"))
   (format #f "#battery.critical { color: ~a; }\n" (hx "base08"))
   "#pulseaudio.muted { color: " (hx "base08") "; }\n\n"
   "#pulseaudio:hover, #network:hover {\n"
   (format #f "  background: ~a;\n" (hx "base02"))
   "  border-radius: 0;\n"
   "}\n"))
