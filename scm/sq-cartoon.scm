;
;   ____    _ __           ____               __    ____
;  / __/___(_) /  ___ ____/ __ \__ _____ ___ / /_  /  _/__  ____
; _\ \/ __/ / _ \/ -_) __/ /_/ / // / -_|_-</ __/ _/ // _ \/ __/
;/___/\__/_/_.__/\__/_/  \___\_\_,_/\__/___/\__/ /___/_//_/\__(_)
;
;Copyright 2008 SciberQuest Inc.
;

(define
  (sq-cartoon inFile outFile ar apct)
    (let*
      (
      ; load background the im
      (im (car (gimp-file-load RUN-NONINTERACTIVE inFile inFile)))
      (dw (car (gimp-image-get-active-layer im)))
      (r 0.0) ; filter radius > 1.0
      (pct 0.1) ; percent of darkened pixels to set to black
      )

      (set! r (string->number ar))
      (set! pct (string->number apct))

      (plug-in-cartoon RUN-NONINTERACTIVE im dw r pct)

      ; save the composite
      (gimp-file-save RUN-NONINTERACTIVE im dw outFile outFile)
      (gimp-image-delete im)
   )
)
