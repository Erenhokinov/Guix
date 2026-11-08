(define-module (stylix zsh)
  ;;zsh

  #:export (zshrc zprofile))

(use-modules (stylix theme))

(define pc-user   (hx "base0F"))   
(define pc-host   (hx "base0D"))   
(define pc-path   (hx "base09"))   
(define pc-arrow  (hx "base0B"))   

(define rcols (map hx '("base08" "base09" "base0A" "base0B" "base0C" "base0D" "base0E")))
(define blocks '("▂" "▄" "▆" "█" "▆" "▄" "▂"))

(define rprompt
  (let loop ((cs rcols) (bs blocks) (acc ""))
    (if (null? cs)
        (string-append "RPROMPT=\"" acc "\"\n")
        (loop (cdr cs) (cdr bs)
              (string-append acc "%F{" (car cs) "}" (car bs) "%f")))))

(define prompt-str
  (string-append
   "PROMPT=\" ◉ %U%F{" pc-user "}%n%f%u@%U%F{" pc-host "}%m%f%u:%F{" pc-path "}%~%f\n"
   " %F{" pc-arrow "}→%f \"\n"))

(define zshrc
  (string-append
   "fpath=(~/.guix-home/profile/share/zsh/plugins/zsh-syntax-highlighting ~/.guix-home/profile/share/zsh/plugins/zsh-autosuggestions $fpath)\n"
   "source ~/.guix-home/profile/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh\n"
   "source ~/.guix-home/profile/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh\n\n"
   "autoload -Uz compinit && compinit\n\n"
   "eval \"$(direnv hook zsh)\"\n\n"
   prompt-str
   rprompt "\n"
   "bindkey '^P' history-beginning-search-backward\n"
   "bindkey '^N' history-beginning-search-forward\n\n"
   "[ $TERM = \"dumb\" ] && unsetopt zle && PS1='$ '\n\n"
   "alias ranger='yazi'\n"
   "alias ls='eza --icons -l -T -L=1'\n"
   "alias cat='bat'\n"
   "alias htop='btm'\n"
   "alias fd='fd -Lu'\n"
   "alias w3m='w3m -no-cookie -v'\n\n"
   "phoenix() {\n"
   "  if [[ $1 == \"gc\" ]]; then\n"
   "    if [[ $2 == \"full\" ]]; then\n"
   "      sudo guix gc --optimize && sudo guix gc --vacuum-database\n"
   "    else\n"
   "      sudo guix gc\n"
   "    fi\n"
   "  elif [[ $1 == \"update\" ]]; then\n"
   "    guix pull\n"
   "  else\n"
   "    echo \"usage: phoenix gc [full] | phoenix update\"\n"
   "  fi\n"
   "}\n"))

(define zprofile
  (string-append
   "source /etc/profile\n"
   "source ~/.profile\n\n"
   "case \"$(tty 2>/dev/null)\" in\n"
   "    /dev/tty[0-9]*)\n"
   "        if [ -z \"$WAYLAND_DISPLAY\" ] && [ -z \"$DISPLAY\" ] \\\n"
   "           && ! pgrep -x Hyprland >/dev/null 2>&1; then\n"
   "            exec hyprland\n"
   "        fi\n"
   "        ;;\n"
   "esac\n"))
