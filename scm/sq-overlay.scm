;    ____    _ ___________  ______
;   / __/___(_) ___/  _/  |/  / _ \
;  _\ \/ __/ / (_ // // /|_/ / ___/
; /___/\__/_/\___/___/_/  /_/_/
;
; Copyright 2014 Burlen Loring
(define
  (sq-overlay inFile overlayFile outFile x0 y0 a0 a1 m1)
    (let*
      (
      ; load background the im
      (im (car (gimp-file-load RUN-NONINTERACTIVE inFile inFile)))
      (dw (car (gimp-image-get-active-layer im)))
      ; load the overlay im
      (la (car (gimp-file-load-layer RUN-NONINTERACTIVE im overlayFile)))
      )
      ; add alpha channel, and set the alpha and blend mode for these layers
      (gimp-layer-add-alpha dw)
      (gimp-layer-set-opacity dw (string->number a0))

      (gimp-layer-add-alpha la)
      (gimp-layer-set-opacity la (string->number a1))
      (gimp-layer-set-mode la (string->number m1))

      ; debug
      ; (gimp-message-set-handler ERROR-CONSOLE)
      ; (gimp-message inFile)
      ; (gimp-message overlayFile)
      ; (gimp-message outFile)
      ; (gimp-message x0)
      ; (gimp-message y0)

      ; position the overlay
      (gimp-image-add-layer im la -1)
      (gimp-layer-set-offsets la (string->number x0) (string->number y0))
      (gimp-layer-resize-to-image-size la)
      (gimp-drawable-set-visible dw 1)
      (gimp-drawable-set-visible la 1)

      ; save the composite
      (gimp-image-merge-visible-layers im  CLIP-TO-IMAGE)
      (set! dw (car (gimp-image-get-active-layer im)))

      (gimp-file-save RUN-NONINTERACTIVE im dw outFile outFile)
      (gimp-image-delete im)
   )
)
