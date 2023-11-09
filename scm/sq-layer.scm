;    ____    _ ___________  ______
;   / __/___(_) ___/  _/  |/  / _ \
;  _\ \/ __/ / (_ // // /|_/ / ___/
; /___/\__/_/\___/___/_/  /_/_/
;
; Copyright 2016 Burlen Loring
(define
  (sq-layer layers xpos ypos alpha mode out)
    (let*
      (
      (im 0)
      (dw 0)
      (f "")
      (x 0)
      (y 0)
      (a 0)
      (m 0)
      (n 0)
      )

      (gimp-message-set-handler ERROR-CONSOLE)

      ; load the base layer
      (set! n (length layers))

      (set! f (car layers))
      (set! x (car xpos))
      (set! y (car ypos))
      (set! a (car alpha))
      (set! m (car mode))
      (set! layers (cdr layers))
      (set! xpos (cdr xpos))
      (set! ypos (cdr ypos))
      (set! alpha (cdr alpha))
      (set! mode (cdr mode))

      ;(gimp-message (string-append "loading layer " f " " (number->string n) " alpha " (number->string a)))

      (set! im (car (gimp-file-load RUN-NONINTERACTIVE f f)))
      (set! dw (car (gimp-image-get-active-layer im)))

      (gimp-layer-add-alpha dw)
      (gimp-layer-set-opacity dw a)
      (gimp-layer-set-mode dw m)
      (gimp-layer-set-offsets dw x y)

      (set! n (- n 1))

      ; load the rest
      (while (> n 0)
        (set! f (car layers))
        (set! x (car xpos))
        (set! y (car ypos))
        (set! a (car alpha))
        (set! m (car mode))
        (set! layers (cdr layers))
        (set! xpos (cdr xpos))
        (set! ypos (cdr ypos))
        (set! alpha (cdr alpha))
        (set! mode (cdr mode))

        ;(gimp-message (string-append "loading layer " f " " (number->string n) " alpha " (number->string a)))

        (set! dw (car (gimp-file-load-layer RUN-NONINTERACTIVE im f)))

        (gimp-image-add-layer im dw -1)
        (gimp-layer-add-alpha dw)
        (gimp-layer-set-opacity dw a)
        (gimp-layer-set-mode dw m)
        (gimp-layer-set-offsets dw x y)
        (gimp-layer-resize-to-image-size dw)
        (gimp-drawable-set-visible dw 1)

        (set! n (- n 1))
      )

      ; save the composite
      ;(gimp-message (string-append "saving " out))
      (gimp-image-merge-visible-layers im  CLIP-TO-IMAGE)
      (set! dw (car (gimp-image-get-active-layer im)))
      (gimp-file-save RUN-NONINTERACTIVE im dw out out)
      (gimp-image-delete im)
   )
)
