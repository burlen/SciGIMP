;   ____    _ __           ____               __    ____
;  / __/___(_) /  ___ ____/ __ \__ _____ ___ / /_  /  _/__  ____
; _\ \/ __/ / _ \/ -_) __/ /_/ / // / -_|_-</ __/ _/ // _ \/ __/
;/___/\__/_/_.__/\__/_/  \___\_\_,_/\__/___/\__/ /___/_//_/\__(_)
;
;Copyright 2008 SciberQuest Inc.

(define
  (sq-rotate inFile outFile deg)
    (let*
      (
      (im     0)
      (dw     0)
      (imw    0)
      (imh    0)
      (cx     0)
      (cy     0)
      ;(theta 90.0)
      )

      ; load the original
      (set! im (car (gimp-file-load RUN-NONINTERACTIVE inFile inFile)))
      (set! dw (car (gimp-image-get-active-layer im)))

      (set! imw (car (gimp-drawable-width dw)))
      (set! imh (car (gimp-drawable-height dw)))

      (set! cx (/ imw 2.0))
      (set! cy (/ imh 2.0))

      (cond
        ((string=? deg "90")
          (gimp-image-rotate im ROTATE-90)
        )
        ((string=? deg "180")
          (gimp-image-rotate im ROTATE-180)
        )
        ((string=? deg "270")
          (gimp-image-rotate im ROTATE-270)
        )
      )

      ;this call seems to have some numerical issues.
      ; rotate
      ;(set! theta (/ (* 3.141592654 (string->number deg)) 180.0))
      ;(set! dw (gimp-drawable-transform-rotate dw theta FALSE cx cy TRANSFORM-FORWARD INTERPOLATION-CUBIC TRUE 3 TRANSFORM-RESIZE-ADJUST))

      ; flatten
      ;(gimp-image-merge-visible-layers im EXPAND-AS-NECESSARY)
      ;(set! dw (car (gimp-image-get-active-layer im)))

      ; save the cropped image
      (gimp-file-save RUN-NONINTERACTIVE im dw outFile outFile)
    )
)
