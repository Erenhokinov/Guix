(define-module (stylix qute)
  ;;qute

  #:export (qute-config-py qute-home-html qute-home-gamedev
            qute-home-teaching qute-home-youtube
            qute-quickmarks qute-containers))

(use-modules (stylix theme))

(define q00 (hx "base00")) (define q01 (hx "base01"))
(define q02 (hx "base02")) (define q03 (hx "base03"))
(define q05 (hx "base05")) (define q07 (hx "base07"))
(define q08 (hx "base08")) (define q09 (hx "base09"))
(define q0a (hx "base10")) (define q0b (hx "base11"))
(define q0c (hx "base12")) (define q0d (hx "base13"))
(define q0e (hx "base14")) (define q0f (hx "base15"))

(define (make-qute-home name)
  (string-append
   "<!DOCTYPE html>\n"
   "<html>\n<head>\n"
   "  <title>My Local Dashboard Awesome Homepage</title>\n"
   "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n"
   "  <style>\n"
   "    body { background-color: " (hx "base00") "; }\n"
   "    a, p {\n"
   "      font-family: 'JetBrains Mono NL';\n"
   "      font-size: 24px;\n"
   "      text-align: center;\n"
   "      color: " (hx "base08") ";\n"
   "      line-height: 1.35;\n"
   "      margin-top: 0;\n"
   "      margin-bottom: 0;\n"
   "      text-decoration: none;\n"
   "    }\n"
   "    a:hover { color: " (hx "base07") "; }\n"
   "    .open { color: " (hx "base09") "; font-weight: bold; }\n"
   "    .open:hover { background-color: " (hx "base09") "; }\n"
   "    .quickmarks { color: " (hx "base10") "; font-weight: bold; }\n"
   "    .quickmarks:hover { background-color: " (hx "base10") "; }\n"
   "    .history { color: " (hx "base11") "; font-weight: bold; }\n"
   "    .history:hover { background-color: " (hx "base11") "; }\n"
   "    .newtab { color: " (hx "base12") "; font-weight: bold; }\n"
   "    .newtab:hover { background-color: " (hx "base12") "; }\n"
   "    .close { color: " (hx "base13") "; font-weight: bold; }\n"
   "    .close:hover { background-color: " (hx "base13") "; }\n"
   "    div { margin: auto; width: 50%; text-align: center; }\n"
   "    .icon { line-height: 10% }\n"
   "  </style>\n"
   "</head>\n<body>\n"
   "  <br><br><br>\n"
   "  <div class=\"icon\">\n"
   "    <img width=\"300\" src=\"logo.png\">\n"
   "  </div>\n"
   "  <br><br><br>\n"
   "  <p style=\"color:" (hx "base01") "\">Welcome to Qutebrowser</p>\n"
   "  <br>\n"
   "  <p><b>" name " Profile</b></p>\n"
   "  <br>\n"
   "  <div>\n"
   "    <a class=\"open\" href=\"https://www.startpage.com\"> [o] [Search] </a>\n"
   "    <a class=\"quickmarks\" href=\"./quickmarks.html\" target=\"_blank\" rel=\"noopener noreferrer\"> [b] [Quickmarks] </a>\n"
   "    <a class=\"newtab\" href=\"./qute-home.html\" target=\"_blank\" rel=\"noopener noreferrer\"> [t] [New tab] </a>\n"
   "    <a class=\"close\" href=\"#\" onclick=\"window.close();return false;\"> [x] [Close tab] </a>\n"
   "  </div>\n"
   "</body>\n</html>\n"))

(define qute-home-html     (make-qute-home "Default"))
(define qute-home-gamedev  (make-qute-home "Gamedev"))
(define qute-home-teaching (make-qute-home "Teaching"))
(define qute-home-youtube  (make-qute-home "Youtube"))

(define qute-containers
  (string-append
   "Gamedev\n"
   "Teaching\n"
   "Youtube\n"))

(define qute-quickmarks
  (string-append
   "gh https://github.com\n"
   "yt https://www.youtube.com\n"
   "wp https://www.wallhaven.cc\n"
   "so https://stackoverflow.com\n"))

(define qute-config-py
  (string-append
   "import sys\n"
   "import os.path\n"
   "secretsExists = False\n"
   "secretFile = os.path.expanduser('~/.config/qutebrowser/qutesecrets.py')\n"
   "if (os.path.isfile(secretFile)):\n"
   "    sys.path.append(os.path.dirname(secretFile))\n"
   "    import qutesecrets\n"
   "    secretsExists = True\n\n"

   "quickmarksFile = os.path.join(os.path.dirname(__file__),'quickmarks')\n"
   "quickmarksHtmlFilePath = os.path.join(os.path.dirname(__file__),'quickmarks.html')\n"
   "quickmarksHtmlFile = open(quickmarksHtmlFilePath,\"w\")\n"
   (format #f "quickmarksHtmlFileText = '<!DOCTYPE html><html><head><title>My Local Dashboard Awesome Homepage</title><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"><style>/*body*/body {background-color: ~a}/*paragraphs*/a, p {font-weight: bold;font-family:JetBrains Mono NL;font-size:24px;text-align:center;color: ~a;line-height: 1.35;margin-top: 0;margin-bottom: 0;text-decoration: none;}a:hover {color: ~a;background-color: ~a;}.title{color: ~a;text-decoration:underline;}</style></head><body><div class=\"icon\"><img width=\"100\" src=\"logo.png\"></div><p class=\"title\">Quickmarks</p><div>'\n"
           q00 q07 q07 q0a q0a)
   "with open(quickmarksFile) as myQuickmarks:\n"
   "    for line in myQuickmarks:\n"
   "        quickmarkData = line.split()\n"
   "        quickmarksHtmlFileText += '<a href=\"'+quickmarkData[1]+'\">'+quickmarkData[0]+'</a><br>'\n"
   "quickmarksHtmlFileText += '</div></body></html>'\n"
   "quickmarksHtmlFile.write(quickmarksHtmlFileText)\n"
   "quickmarksHtmlFile.close()\n\n"

   "config.set('content.blocking.method','both')\n"
   "config.set('scrolling.smooth',True)\n"
   "config.set('qt.args',['ignore-gpu-blacklist','enable-gpu-rasterization','enable-accelerated-video-decode','enable-quic','enable-zero-copy','enable-native-gpu-memory-buffers','num-raster-threads=4','allow-file-access-from-files','enable-features=VaapiVideoDecoder,VaapiIgnoreDriverChecks,Vulkan,DefaultANGLEVulkan,VulkanFromANGLE'])\n"
   "config.set('qt.workarounds.disable_accelerated_2d_canvas','never')\n"
   "config.load_autoconfig(True)\n\n"

   "config.set('content.cookies.accept', 'no-3rdparty', 'chrome-devtools://*')\n"
   "config.set('content.cookies.accept', 'no-3rdparty', 'devtools://*')\n"
   "config.set('content.headers.user_agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'https://accounts.google.com/*')\n"
   "config.set('content.headers.user_agent', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36', 'https://*.slack.com/*')\n"
   "config.set('content.images', True, 'chrome-devtools://*')\n"
   "config.set('content.images', True, 'devtools://*')\n"
   "config.set('content.javascript.enabled', True, 'chrome-devtools://*')\n"
   "config.set('content.javascript.enabled', True, 'devtools://*')\n"
   "config.set('content.javascript.enabled', True, 'chrome://*/*')\n"
   "config.set('content.javascript.enabled', True, 'qute://*/*')\n\n"

   (format #f "base00 = '~a'\nbase01 = '~a'\nbase02 = '~a'\nbase03 = '~a'\nbase04 = '~a'\nbase05 = '~a'\nbase06 = '~a'\nbase07 = '~a'\nbase08 = '~a'\nbase09 = '~a'\nbase0A = '~a'\nbase0B = '~a'\nbase0C = '~a'\nbase0D = '~a'\nbase0E = '~a'\nbase0F = '~a'\n\n"
           q00 q01 q02 q03 (hx "base04") q05 (hx "base06") q07 q08 q09 q0a q0b q0c q0d q0e q0f)
   "\n"

   "c.tabs.favicons.scale = 1.0\n"
   "c.tabs.last_close = 'close'\n"
   "c.tabs.position = 'left'\n"
   "c.tabs.width = '3%'\n"
   "c.window.transparent = True\n"
   "c.colors.webpage.darkmode.enabled = True\n"
   "c.colors.webpage.preferred_color_scheme = 'dark'\n"
   "c.colors.webpage.darkmode.policy.images = 'never'\n\n"

   "c.url.default_page = os.path.join(os.path.dirname(__file__),'qute-home.html')\n"
   "c.url.start_pages = os.path.join(os.path.dirname(__file__),'qute-home.html')\n"
   "c.url.searchengines = {'DEFAULT': 'https://search.brave.com/search?q={}&source=web',\n"
   "                       'yt'     : 'https://www.youtube.com/results?search_query={}',\n"
   "                      }\n\n"

   "config.set('completion.open_categories',['searchengines','quickmarks','bookmarks'])\n"
   "config.set('downloads.location.directory', '~/Downloads')\n"
   "config.set('downloads.location.prompt', False)\n"
   "config.set('downloads.position', 'bottom')\n"
   "config.set('downloads.remove_finished', 10000)\n"
   "config.set('fileselect.handler', 'external')\n"
   "config.set('fileselect.single_file.command', ['alacritty','-e','yazi','--chooser-file={}'])\n"
   "config.set('fileselect.multiple_files.command', ['alacritty','-e','yazi','--chooser-file={}'])\n"
   "config.set('fileselect.folder.command', ['alacritty','-e','yazi','--chooser-file={}'])\n\n"

   "config.bind('<Alt-x>', 'cmd-set-text :')\n"
   "config.bind('<Space>.', 'cmd-set-text :')\n"
   "config.bind('<Space>b', 'bookmark-list')\n"
   "config.bind('<Space>h', 'history')\n"
   "config.bind('<Space>gh', 'open https://github.com')\n"
   "config.bind('<Space>gl', 'open https://gitlab.com')\n"
   "config.bind('<Space>gc', 'open https://codeberg.org')\n"
   "if (secretsExists):\n"
   "    config.bind('<Space>gg', 'open '+qutesecrets.mygiteadomain)\n"
   "config.bind('<Ctrl-p>', 'completion-item-focus prev', mode='command')\n"
   "config.bind('<Ctrl-n>', 'completion-item-focus next', mode='command')\n"
   "config.bind('<Ctrl-p>', 'fake-key <Up>', mode='normal')\n"
   "config.bind('<Ctrl-n>', 'fake-key <Down>', mode='normal')\n"
   "config.bind('<Ctrl-p>', 'fake-key <Up>', mode='insert')\n"
   "config.bind('<Ctrl-n>', 'fake-key <Down>', mode='insert')\n"
   "config.bind('<Ctrl-p>', 'fake-key <Up>', mode='passthrough')\n"
   "config.bind('<Ctrl-n>', 'fake-key <Down>', mode='passthrough')\n\n"

   "config.bind('t', 'open -t')\n"
   "config.bind('x', 'tab-close')\n"
   "config.bind('yf', 'hint links yank')\n"
   "config.bind('<Ctrl-Tab>', 'tab-next')\n"
   "config.bind('<Ctrl-Shift-Tab>', 'tab-prev')\n\n"

   "config.bind('<Shift-Escape>', 'mode-leave', mode='passthrough')\n"
   "config.bind('<Ctrl-T>', 'open -t', mode='passthrough')\n"
   "config.bind('<Ctrl-W>', 'tab-close', mode='passthrough')\n"
   "config.bind('<Ctrl-Tab>', 'tab-next', mode='passthrough')\n"
   "config.bind('<Ctrl-Shift-Tab>', 'tab-prev', mode='passthrough')\n"
   "config.bind('<Ctrl-B>', 'cmd-set-text -s :quickmark-load -t', mode='passthrough')\n"
   "config.bind('<Ctrl-O>', 'cmd-set-text -s :open -t', mode='passthrough')\n"
   "config.bind('<Ctrl-F>', 'cmd-set-text /', mode='passthrough')\n"
   "config.bind('<Ctrl-R>', 'reload', mode='passthrough')\n"
   "config.unbind('<Ctrl-X>')\n"
   "config.unbind('<Ctrl-A>')\n\n"

   "config.bind(',m', 'hint links spawn mpv {hint-url}')\n"
   "config.bind(',co', 'spawn container-open')\n"
   "config.bind(',cf', 'hint links userscript container-open')\n\n"

   (format #f "c.colors.completion.fg = base05\nc.colors.completion.odd.bg = base01\nc.colors.completion.even.bg = base00\nc.colors.completion.category.fg = base0B\nc.colors.completion.category.bg = base00\nc.colors.completion.category.border.top = base00\nc.colors.completion.category.border.bottom = base00\nc.colors.completion.item.selected.fg = base05\nc.colors.completion.item.selected.bg = base02\nc.colors.completion.item.selected.border.top = base02\nc.colors.completion.item.selected.border.bottom = base02\nc.colors.completion.item.selected.match.fg = base0B\nc.colors.completion.match.fg = base0B\nc.colors.completion.scrollbar.fg = base05\nc.colors.completion.scrollbar.bg = base00\nc.colors.contextmenu.disabled.bg = base01\nc.colors.contextmenu.disabled.fg = base04\nc.colors.contextmenu.menu.bg = base00\nc.colors.contextmenu.menu.fg = base05\nc.colors.contextmenu.selected.bg = base02\nc.colors.contextmenu.selected.fg = base05\nc.colors.downloads.bar.bg = base00\nc.colors.downloads.start.fg = base00\nc.colors.downloads.start.bg = base0D\nc.colors.downloads.stop.fg = base00\nc.colors.downloads.stop.bg = base0C\nc.colors.downloads.error.fg = base08\nc.colors.hints.fg = base00\nc.colors.hints.bg = base0A\nc.colors.hints.match.fg = base05\nc.colors.keyhint.fg = base05\nc.colors.keyhint.suffix.fg = base05\nc.colors.keyhint.bg = base00\nc.colors.messages.error.fg = base00\nc.colors.messages.error.bg = base08\nc.colors.messages.error.border = base08\nc.colors.messages.warning.fg = base00\nc.colors.messages.warning.bg = base0E\nc.colors.messages.warning.border = base0E\nc.colors.messages.info.fg = base05\nc.colors.messages.info.bg = base00\nc.colors.messages.info.border = base00\nc.colors.prompts.fg = base05\nc.colors.prompts.border = base00\nc.colors.prompts.bg = base00\nc.colors.prompts.selected.bg = base02\nc.colors.prompts.selected.fg = base05\nc.colors.statusbar.normal.fg = base0B\nc.colors.statusbar.normal.bg = base00\nc.colors.statusbar.insert.fg = base00\nc.colors.statusbar.insert.bg = base0D\nc.colors.statusbar.passthrough.fg = base00\nc.colors.statusbar.passthrough.bg = base0C\nc.colors.statusbar.private.fg = base00\nc.colors.statusbar.private.bg = base01\nc.colors.statusbar.command.fg = base05\nc.colors.statusbar.command.bg = base00\nc.colors.statusbar.command.private.fg = base05\nc.colors.statusbar.command.private.bg = base00\nc.colors.statusbar.caret.fg = base00\nc.colors.statusbar.caret.bg = base0E\nc.colors.statusbar.caret.selection.fg = base00\nc.colors.statusbar.caret.selection.bg = base0D\nc.colors.statusbar.progress.bg = base0D\nc.colors.statusbar.url.fg = base05\nc.colors.statusbar.url.error.fg = base08\nc.colors.statusbar.url.hover.fg = base05\nc.colors.statusbar.url.success.http.fg = base0C\nc.colors.statusbar.url.success.https.fg = base0B\nc.colors.statusbar.url.warn.fg = base0E\nc.colors.tabs.bar.bg = base00\nc.colors.tabs.indicator.start = base0D\nc.colors.tabs.indicator.stop = base0C\nc.colors.tabs.indicator.error = base08\nc.colors.tabs.odd.fg = base05\nc.colors.tabs.odd.bg = base01\nc.colors.tabs.even.fg = base05\nc.colors.tabs.even.bg = base00\nc.colors.tabs.pinned.even.bg = base0C\nc.colors.tabs.pinned.even.fg = base07\nc.colors.tabs.pinned.odd.bg = base0B\nc.colors.tabs.pinned.odd.fg = base07\nc.colors.tabs.pinned.selected.even.bg = base02\nc.colors.tabs.pinned.selected.even.fg = base05\nc.colors.tabs.pinned.selected.odd.bg = base02\nc.colors.tabs.pinned.selected.odd.fg = base05\nc.colors.tabs.selected.odd.fg = base05\nc.colors.tabs.selected.odd.bg = base02\nc.colors.tabs.selected.even.fg = base05\nc.colors.tabs.selected.even.bg = base02\nc.colors.tooltip.bg = base00\nc.colors.tooltip.fg = base05\n")

   "font = 'JetBrains Mono NL'\n"
   "c.fonts.default_family = font\n"
   "c.fonts.default_size = '14pt'\n"
   "c.fonts.web.family.standard = font\n"
   "c.fonts.web.family.serif = font\n"
   "c.fonts.web.family.sans_serif = font\n"
   "c.fonts.web.family.fixed = font\n"
   "c.fonts.web.family.fantasy = font\n"
   "c.fonts.web.family.cursive = font\n"))
