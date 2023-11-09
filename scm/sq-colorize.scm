;    ____    _ ___________  ______
;   / __/___(_) ___/  _/  |/  / _ \
;  _\ \/ __/ / (_ // // /|_/ / ___/
; /___/\__/_/\___/___/_/  /_/_/
;
; Copyright 2016 Burlen Loring

(define
  (sq-colorize inFile hh ss ll outFile)
    (let*
      (
      (im   0)
      (dw   0)
      )

      ; load the original
      (set! im (car (gimp-file-load RUN-NONINTERACTIVE inFile inFile)))
      (set! dw (car (gimp-image-get-active-layer im)))

      ; apply the filter
      (gimp-colorize dw (string->number hh) (string->number ss) (string->number ll))

      ; save the masked image
      (set! dw (car (gimp-image-get-active-layer im)))
      (gimp-file-save RUN-NONINTERACTIVE im dw outFile outFile)
    )
)



