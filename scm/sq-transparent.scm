;
;   ____    _ __           ____               __    ____
;  / __/___(_) /  ___ ____/ __ \__ _____ ___ / /_  /  _/__  ____
; _\ \/ __/ / _ \/ -_) __/ /_/ / // / -_|_-</ __/ _/ // _ \/ __/
;/___/\__/_/_.__/\__/_/  \___\_\_,_/\__/___/\__/ /___/_//_/\__(_)
;
;Copyright 2014 SciberQuest Inc.
;

(define
  (sq-transparent inFile outFile rr gg bb tt rad)
    (let*
      (
      (imw  0)    ; image width
      (imh  0)    ; image ht
      (r    0)    ; red component
      (g    0)    ; green component
      (b    0)    ; blue component
      (t    0)    ; threshold
      (fr   0)    ; feather radius
      (f    0)    ; use feather radius
      (im   0)    ; image
      (dw   0)    ; drawable
      )

      (set! im (car (gimp-file-load RUN-NONINTERACTIVE inFile inFile)))
      (set! dw (car (gimp-image-get-active-layer im)))

      (set! imw (car (gimp-drawable-width dw)))
      (set! imh (car (gimp-drawable-height dw)))

      (set! r (string->number rr))
      (set! g (string->number gg))
      (set! b (string->number bb))
      (set! t (string->number tt))
      (set! fr (string->number rad))

      (if (> fr 0) (set! f TRUE) (set! f FALSE))

      (gimp-message-set-handler ERROR-CONSOLE)

      (gimp-layer-add-alpha dw)
      (gimp-by-color-select dw (list r g b) t CHANNEL-OP-REPLACE TRUE f fr FALSE)
      (gimp-edit-clear dw)

      (gimp-file-save RUN-NONINTERACTIVE im dw outFile outFile)
      (gimp-image-delete im)
   )
)

