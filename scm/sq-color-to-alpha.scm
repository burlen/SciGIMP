;   ____    _ __           ____               __    ____
;  / __/___(_) /  ___ ____/ __ \__ _____ ___ / /_  /  _/__  ____
; _\ \/ __/ / _ \/ -_) __/ /_/ / // / -_|_-</ __/ _/ // _ \/ __/
;/___/\__/_/_.__/\__/_/  \___\_\_,_/\__/___/\__/ /___/_//_/\__(_)
;
;Copyright 2008 SciberQuest Inc.

(define
  (sq-color-to-alpha inFile rr gg bb outFile)
    (let*
      (
      (im   0)
      (dw   0)
      (r    0)
      (g    0)
      (b    0)
      )

      ; load the original
      (set! im (car (gimp-file-load RUN-NONINTERACTIVE inFile inFile)))
      (set! dw (car (gimp-image-get-active-layer im)))

      ; add an alpha channel
      (gimp-layer-add-alpha dw)

      ; get the color
      (set! r (string->number rr))
      (set! g (string->number gg))
      (set! b (string->number bb))

      ; convert
      (plug-in-colortoalpha RUN-NONINTERACTIVE im dw (list r g b))

      ; save the image
      (gimp-file-save RUN-NONINTERACTIVE im dw outFile outFile)
    )
)
