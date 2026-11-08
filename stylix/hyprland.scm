(define-module (stylix hyprland)
  ;;hyprland

  #:export (hyprland-config hyprpaper-conf vibrance-frag))

(use-modules (srfi srfi-11) (stylix theme))

(define c00 (hx "base00")) (define c01 (hx "base01"))
(define c02 (hx "base02")) (define c03 (hx "base03"))
(define c05 (hx "base05")) (define c06 (hx "base06"))
(define c08 (hx "base08")) (define c09 (hx "base09"))
(define c0a (hx "base10")) (define c0b (hx "base11"))
(define c0c (hx "base12")) (define c0d (hx "base13"))
(define c0e (hx "base14")) (define c0f (hx "base15"))

(define border-gradient
  (format #f "'~a'" c0d))

(define hyprland-config
  (string-append
   "hl.monitor({\n"
   "    output   = '',\n"
   "    mode     = 'preferred',\n"
   "    position = 'auto',\n"
   "    scale    = '1',\n"
   "})\n\n"

   "local terminal = 'alacritty'\n"
   "local menu     = 'rofi -show drun'\n"
   "local browser  = 'qutebrowser'\n"
   "local editor   = 'vscodium'\n"
   "local vesktop  = 'vesktop'\n\n"

   "hl.env('BROWSER', 'qutebrowser')\n"
   "hl.env('FILE_MANAGER', 'alacritty -e yazi')\n"
   "hl.env('XCURSOR_SIZE', '24')\n"
   "hl.env('HYPRCURSOR_SIZE', '24')\n"
   "hl.env('XCURSOR_THEME', 'whiteglass')\n"
   "hl.env('ELECTRON_OZONE_PLATFORM_HINT', 'wayland')\n"
   "hl.env('GDK_BACKEND', 'wayland,x11,*')\n\n"

   "hl.on('hyprland.start', function ()\n"
   "    hl.exec_cmd('hyprpaper')\n"
   "    hl.exec_cmd('waybar')\n"
   "    hl.exec_cmd('/run/current-system/profile/bin/polkit-gnome-authentication-agent-1')\n"
   "end)\n\n"

   "hl.config({\n"
   "    general = {\n"
   "        gaps_in  = 20,\n"
   "        gaps_out = 32,\n"
   "\n"
   "        border_size = 2,\n"
   "\n"
   (string-append
    "        col = {\n"
    "            active_border   = " border-gradient ",\n"
    (let-values (((r g b) (rgb-of "base02")))
      (format #f "            inactive_border = 'rgba(~a,~a,~a,0.66)',\n" r g b))
    "        },\n")
   "\n"
   "        resize_on_border = true,\n"
   "        allow_tearing    = false,\n"
   "        layout           = 'dwindle',\n"
   "    },\n\n"

   "    decoration = {\n"
   "        rounding       = 0,\n"
   "        rounding_power = 2,\n"
   "\n"
   "        active_opacity   = 0.7,\n"
   "        inactive_opacity = 0.5,\n"
   "\n"
   "        shadow = {\n"
   "            enabled      = true,\n"
   "            range        = 18,\n"
   "            render_power = 3,\n"
   (let-values (((r g b) (rgb-of "base00")))
     (format #f "            color        = 'rgba(~a,~a,~a,0.6)',\n" r g b))
   "        },\n"
   "\n"
   "        blur = {\n"
   "            enabled    = true,\n"
   "            size       = 12,\n"
   "            passes     = 4,\n"
   "            vibrancy   = 0.2,\n"
   "            contrast   = 1.17,\n"
   "            brightness = 0.7,\n"
   "            noise      = 0.015,\n"
   "        },\n"
   "    },\n\n"

   "    cursor = {\n"
   "        no_hardware_cursors = true,\n"
   "    },\n\n"

   "    animations = {\n"
   "        enabled = true,\n"
   "    },\n"
   "})\n\n"

   "hl.curve('easeOutQuint',   { type = 'bezier', points = { {0.23, 1},    {0.32, 1}    } })\n"
   "hl.curve('easeInOutCubic', { type = 'bezier', points = { {0.65, 0.05}, {0.36, 1}    } })\n"
   "hl.curve('linear',         { type = 'bezier', points = { {0, 0},       {1, 1}       } })\n"
   "hl.curve('almostLinear',   { type = 'bezier', points = { {0.5, 0.5},   {0.75, 1}    } })\n"
   "hl.curve('quick',          { type = 'bezier', points = { {0.15, 0},    {0.1, 1}     } })\n"
   "hl.curve('easy', { type = 'spring', mass = 1, stiffness = 71.2633, dampening = 15.8273644 })\n\n"

   "hl.animation({ leaf = 'global',        enabled = true, speed = 10,   bezier = 'default' })\n"
   "hl.animation({ leaf = 'border',        enabled = true, speed = 5.39, bezier = 'easeOutQuint' })\n"
   "hl.animation({ leaf = 'windows',       enabled = true, speed = 4.79, spring = 'easy' })\n"
   "hl.animation({ leaf = 'windowsIn',     enabled = true, speed = 4.1,  spring = 'easy', style = 'popin 87%' })\n"
   "hl.animation({ leaf = 'windowsOut',    enabled = true, speed = 1.49, bezier = 'linear', style = 'popin 87%' })\n"
   "hl.animation({ leaf = 'fadeIn',        enabled = true, speed = 1.73, bezier = 'almostLinear' })\n"
   "hl.animation({ leaf = 'fadeOut',       enabled = true, speed = 1.46, bezier = 'almostLinear' })\n"
   "hl.animation({ leaf = 'fade',          enabled = true, speed = 3.03, bezier = 'quick' })\n"
   "hl.animation({ leaf = 'layers',        enabled = true, speed = 3.81, bezier = 'easeOutQuint' })\n"
   "hl.animation({ leaf = 'layersIn',      enabled = true, speed = 4,    bezier = 'easeOutQuint', style = 'fade' })\n"
   "hl.animation({ leaf = 'layersOut',     enabled = true, speed = 1.5,  bezier = 'linear', style = 'fade' })\n"
   "hl.animation({ leaf = 'workspaces',    enabled = true, speed = 1.94, bezier = 'almostLinear', style = 'fade' })\n"
   "hl.animation({ leaf = 'workspacesIn',  enabled = true, speed = 1.21, bezier = 'almostLinear', style = 'fade' })\n"
   "hl.animation({ leaf = 'workspacesOut', enabled = true, speed = 1.94, bezier = 'almostLinear', style = 'fade' })\n"
   "hl.animation({ leaf = 'zoomFactor',    enabled = true, speed = 7,    bezier = 'quick' })\n\n"

   "hl.config({ dwindle = { preserve_split = true } })\n"
   "hl.config({ master  = { new_status = 'master' } })\n"
   "hl.config({ group   = { auto_group = false, groupbar = { enabled = false } } })\n\n"

   "hl.config({\n"
   "    misc = {\n"
   "        force_default_wallpaper = -1,\n"
   "        disable_hyprland_logo   = true,\n"
   "        font_family             = 'JetBrains Mono NL',\n"
   "    },\n"
   "})\n\n"

   "hl.config({\n"
   "    input = {\n"
   "        kb_layout  = 'us,ru',\n"
   "        kb_variant = '',\n"
   "        kb_model   = '',\n"
   "        kb_options = 'grp:alt_shift_toggle',\n"
   "        kb_rules   = '',\n"
   "\n"
   "        follow_mouse = 1,\n"
   "        sensitivity  = 0,\n"
   "	force_no_accel = true;\n"
   "	accel_profile = flat,\n"
   "\n"
   "        touchpad = {\n"
   "            natural_scroll = false,\n"
   "        },\n"
   "    },\n"
   "})\n\n"

   "local mainMod = 'SUPER'\n\n"

   "hl.bind(mainMod .. ' + Return', hl.dsp.exec_cmd(terminal))\n"
   "hl.bind(mainMod .. ' + A',      hl.dsp.exec_cmd(editor))\n"
   "hl.bind(mainMod .. ' + Q',      hl.dsp.window.close())\n"
   "hl.bind(mainMod .. ' + D',      hl.dsp.exec_cmd(vesktop))\n"
   "hl.bind(mainMod .. ' + B',      hl.dsp.exec_cmd(browser))\n"
   "hl.bind(mainMod .. ' + M',      hl.dsp.exit())\n"
   "hl.bind(mainMod .. ' + V',      hl.dsp.window.float({ action = 'toggle' }))\n"
   "hl.bind(mainMod .. ' + T',      hl.dsp.window.float({ action = 'toggle' }))\n"
   "hl.bind(mainMod .. ' + P',      hl.dsp.window.pseudo())\n"
   "hl.bind(mainMod .. ' + J',      hl.dsp.layout('togglesplit'))\n"
   "hl.bind(mainMod .. ' + SPACE',  hl.dsp.window.fullscreen())\n"
   "hl.bind(mainMod .. ' + SHIFT + SPACE', hl.dsp.window.fullscreen({ action = 'unset' }))\n"
   "hl.bind(mainMod .. ' + TAB',    hl.dsp.exec_cmd('hyprctl dispatch cyclenext'))\n"
   "hl.bind(mainMod .. ' + SUPER_L', hl.dsp.exec_cmd(menu), { release = true })\n\n"

   "hl.bind(mainMod .. ' + left',  hl.dsp.focus({ direction = 'left' }))\n"
   "hl.bind(mainMod .. ' + right', hl.dsp.focus({ direction = 'right' }))\n"
   "hl.bind(mainMod .. ' + up',    hl.dsp.focus({ direction = 'up' }))\n"
   "hl.bind(mainMod .. ' + down',  hl.dsp.focus({ direction = 'down' }))\n"
   "hl.bind('ALT + TAB',           hl.dsp.exec_cmd('hyprctl dispatch cyclenext'))\n\n"

   "for i = 1, 10 do\n"
   "    local key = i % 10\n"
   "    hl.bind(mainMod .. ' + ' .. key,         hl.dsp.focus({ workspace = i }))\n"
   "    hl.bind(mainMod .. ' + SHIFT + ' .. key, hl.dsp.window.move({ workspace = i }))\n"
   "end\n\n"

   "hl.bind(mainMod .. ' + S',         hl.dsp.workspace.toggle_special('magic'))\n"
   "hl.bind(mainMod .. ' + SHIFT + S', hl.dsp.window.move({ workspace = 'special:magic' }))\n\n"

   "hl.bind(mainMod .. ' + Z', hl.dsp.exec_cmd('hyprctl clients -j | grep -q scratch_term && hyprctl dispatch togglespecialworkspace scratch || alacritty --class scratch_term'))\n\n"
   "hl.bind(mainMod .. ' + F', hl.dsp.exec_cmd('hyprctl clients -j | grep -q scratch_yazi && hyprctl dispatch togglespecialworkspace scratch_yazi || alacritty --class scratch_yazi -e yazi'))\n\n"

   "hl.bind(mainMod .. ' + PRINT',        hl.dsp.exec_cmd('grim'))\n"
   "hl.bind('SHIFT + PRINT',              hl.dsp.exec_cmd('grim -g \"$(slurp)\"'))\n"
   "hl.bind('CTRL + PRINT',               hl.dsp.exec_cmd('grim - | wl-copy'))\n"
   "hl.bind('CTRL + SHIFT + PRINT',       hl.dsp.exec_cmd('grim -g \"$(slurp)\" - | wl-copy'))\n"
   "hl.bind(mainMod .. ' + C',            hl.dsp.exec_cmd('hyprpicker -a'))\n"
   "hl.bind('CTRL + ALT + DELETE',        hl.dsp.exec_cmd('hyprctl kill'))\n\n"

   "hl.bind(mainMod .. ' + mouse_down', hl.dsp.focus({ workspace = 'e+1' }))\n"
   "hl.bind(mainMod .. ' + mouse_up',   hl.dsp.focus({ workspace = 'e-1' }))\n"
   "hl.bind(mainMod .. ' + mouse:272', hl.dsp.window.drag(),   { mouse = true })\n"
   "hl.bind(mainMod .. ' + mouse:273', hl.dsp.window.resize(), { mouse = true })\n\n"

   "hl.bind('XF86AudioRaiseVolume', hl.dsp.exec_cmd('wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+'), { locked = true, repeating = true })\n"
   "hl.bind('XF86AudioLowerVolume', hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-'),      { locked = true, repeating = true })\n"
   "hl.bind('XF86AudioMute',        hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'),     { locked = true, repeating = true })\n"
   "hl.bind('XF86MonBrightnessUp',  hl.dsp.exec_cmd('brightnessctl -e4 -n2 set 5%+'),                  { locked = true, repeating = true })\n"
   "hl.bind('XF86MonBrightnessDown',hl.dsp.exec_cmd('brightnessctl -e4 -n2 set 5%-'),                  { locked = true, repeating = true })\n\n"

   "hl.window_rule({\n"
   "    name  = 'fix-xwayland-drags',\n"
   "    match = { class = '^$', title = '^$', xwayland = true, float = true, fullscreen = false, pin = false },\n"
   "    no_focus = true,\n"
   "})\n\n"

   "hl.window_rule({\n"
   "    name  = 'scratch-term',\n"
   "    match = { class = '^(scratch_term)$' },\n"
   "    float = true,\n"
   "    size  = '80% 85%',\n"
   "    center = true,\n"
   "    workspace = 'special:scratch',\n"
   "})\n\n"

   "hl.window_rule({\n"
   "    name  = 'scratch-yazi',\n"
   "    match = { class = '^(scratch_yazi)$' },\n"
   "    float = true,\n"
   "    size  = '80% 85%',\n"
   "    center = true,\n"
   "    workspace = 'special:scratch_yazi',\n"
   "})\n\n"

   "hl.window_rule({\n"
   "    name  = 'filechoose-yazi',\n"
   "    match = { class = '^(filechoose_yazi)$' },\n"
   "    float = true,\n"
   "    size  = '80% 85%',\n"
   "    center = true,\n"
   "})\n\n"

   "hl.window_rule({\n"
   "    name  = 'vesktop-float',\n"
   "    match = { class = '^(vesktop)$' },\n"
   "    float = true,\n"
   "    size  = '85% 90%',\n"
   "    center = true,\n"
   "})\n\n"

   "hl.layer_rule({\n"
   "    name  = 'waybar-blur',\n"
   "    match = { namespace = '^waybar$' },\n"
   "    blur  = true,\n"
   "    ignore_alpha = 0.0,\n"
   "})\n"
   "hl.layer_rule({\n"
   "    name  = 'rofi-blur',\n"
   "    match = { namespace = '^rofi$' },\n"
   "    ignore_alpha = 0.0,\n"
   "})\n"))

(define hyprpaper-conf
  (string-append
   "splash = false\n\n"
   "wallpaper {\n"
   "    monitor = eDP-1\n"
   "    path    = /home/noname/.config/hypr/wallpaper.jpg\n"
   "    fit_mode = cover\n"
   "}\n\n"
   "wallpaper {\n"
   "    monitor = HDMI-A-1\n"
   "    path    = /home/noname/.config/hypr/wallpaper.jpg\n"
   "    fit_mode = cover\n"
   "}\n"))

(define vibrance-frag
  (string-append
   "#version 320 es\n"
   "precision highp float;\n"
   "in vec2 v_texcoord;\n"
   "uniform sampler2D tex;\n"
   "uniform float vibrance;\n"
   "layout(location = 0) out vec4 fragColor;\n\n"
   "void main() {\n"
   "    vec4 pixColor = texture(tex, v_texcoord);\n"
   "    float luma = dot(pixColor.rgb, vec3(0.299, 0.587, 0.114));\n"
   "    vec3 vibrant = mix(vec3(luma), pixColor.rgb, 1.25);\n"
   "    fragColor = vec4(clamp(vibrant, 0.0, 1.0), pixColor.a);\n"
   "}\n"))
