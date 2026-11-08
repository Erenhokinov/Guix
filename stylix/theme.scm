(define-module (stylix theme)
  ;;theme

  #:export (base00 base01 base02 base03 base04 base05 base06 base07
            base08 base09 base10 base11 base12 base13 base14 base15
            colors hx rgb-of brightness))

(define base00 "161b1d")
(define base01 "1f292e")
(define base02 "516d7b")
(define base03 "5a7b8c")
(define base04 "7195a8")
(define base05 "7ea2b4")
(define base06 "c1e4f6")
(define base07 "ebf8ff")
(define base08 "d22d72")
(define base09 "935c25")
(define base10 "8a8a0f")
(define base11 "568c3b")
(define base12 "2d8f6f")
(define base13 "257fad")
(define base14 "6b6bb8")
(define base15 "b72dd2")

(define colors
  `(("base00" . ,base00) ("base01" . ,base01) ("base02" . ,base02)
    ("base03" . ,base03) ("base04" . ,base04) ("base05" . ,base05)
    ("base06" . ,base06) ("base07" . ,base07) ("base08" . ,base08)
    ("base09" . ,base09) ("base10" . ,base10) ("base11" . ,base11)
    ("base12" . ,base12) ("base13" . ,base13) ("base14" . ,base14)
    ("base15" . ,base15)
    ("base0A" . ,base10) ("base0B" . ,base11) ("base0C" . ,base12)
    ("base0D" . ,base13) ("base0E" . ,base14) ("base0F" . ,base15)))

(define (color name) (cdr (assoc name colors)))

(define (hx name) (string-append "#" (color name)))

(define (rgb-of name)
  (let ((h (color name)))
    (values (string->number (substring h 0 2) 16)
            (string->number (substring h 2 4) 16)
            (string->number (substring h 4 6) 16))))

(define (brightness hex f)
  (define (chan i)
    (let* ((s (substring hex i (+ i 2)))
           (v (inexact->exact
               (min 255 (max 0 (round (* f (string->number s 16)))))))
           (h (number->string v 16)))
      (if (< (string-length h) 2) (string-append "0" h) h)))
  (string-append "#" (chan 1) (chan 3) (chan 5)))
