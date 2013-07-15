;   ____    _ __           ____               __    ____
;  / __/___(_) /  ___ ____/ __ \__ _____ ___ / /_  /  _/__  ____
; _\ \/ __/ / _ \/ -_) __/ /_/ / // / -_|_-</ __/ _/ // _ \/ __/
;/___/\__/_/_.__/\__/_/  \___\_\_,_/\__/___/\__/ /___/_//_/\__(_)
;
;Copyright 2008 SciberQuest Inc.

(define
  (sq-flip inFile outFile flip)
    (let*
      (
      (im     0)
      (dw     0)
      (imw    0)
      (imh    0)
      (cx     0)
      (cy     0)
      )

      ; load the original
      (set! im (car (gimp-file-load RUN-NONINTERACTIVE inFile inFile)))
      (set! dw (car (gimp-image-get-active-layer im)))

      (set! imw (car (gimp-drawable-width dw)))
      (set! imh (car (gimp-drawable-height dw)))

      (set! cx (/ imw 2.0))
      (set! cy (/ imh 2.0))

      ; flip
      (cond
        ((string=? flip "x")
          (gimp-image-flip im ORIENTATION-VERTICAL)
          ;(set! dw (gimp-drawable-transform-flip dw 0 cy imw cy TRANSFORM-FORWARD INTERPOLATION-CUBIC TRUE 3 TRUE))
        )
        ((string=? flip "y")
          (gimp-image-flip im ORIENTATION-HORIZONTAL)
          ;(set! dw (gimp-drawable-transform-flip dw cx 0 cx imh TRANSFORM-FORWARD INTERPOLATION-CUBIC TRUE 3 TRUE))
        )
        ((string=? flip "xy")
          (gimp-image-flip im ORIENTATION-VERTICAL)
          (gimp-image-flip im ORIENTATION-HORIZONTAL)
          ;(set! dw (gimp-drawable-transform-flip dw 0 cy imw cy TRANSFORM-FORWARD INTERPOLATION-CUBIC TRUE 3 TRUE))
          ;(set! dw (gimp-drawable-transform-flip dw cx 0 cx imh TRANSFORM-FORWARD INTERPOLATION-CUBIC TRUE 3 TRUE))
        )
        ((string=? flip "yx")
          (gimp-image-flip im ORIENTATION-HORIZONTAL)
          (gimp-image-flip im ORIENTATION-VERTICAL)
          ;(set! dw (gimp-drawable-transform-flip dw cx 0 cx imh TRANSFORM-FORWARD INTERPOLATION-CUBIC TRUE 3 TRUE))
          ;(set! dw (gimp-drawable-transform-flip dw 0 cy imw cy TRANSFORM-FORWARD INTERPOLATION-CUBIC TRUE 3 TRUE))
        )
      )

      ; flatten
      ;(gimp-image-merge-visible-layers im EXPAND-AS-NECESSARY)
      ;(set! dw (car (gimp-image-get-active-layer im)))

      ; save
      (gimp-file-save RUN-NONINTERACTIVE im dw outFile outFile)
    )
)
