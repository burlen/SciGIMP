;
;   ____    _ __           ____               __    ____
;  / __/___(_) /  ___ ____/ __ \__ _____ ___ / /_  /  _/__  ____
; _\ \/ __/ / _ \/ -_) __/ /_/ / // / -_|_-</ __/ _/ // _ \/ __/
;/___/\__/_/_.__/\__/_/  \___\_\_,_/\__/___/\__/ /___/_//_/\__(_)
;
;Copyright 2008 SciberQuest Inc.
;

(define
  (sq-blur inFile outFile fr)
    (let*
      (
      ; load background the im
      (im (car (gimp-file-load RUN-NONINTERACTIVE inFile inFile)))
      (dw (car (gimp-image-get-active-layer im)))
      (r 0.0) ; filter radius
      )

      (set! r (string->number fr))
      (plug-in-gauss RUN-NONINTERACTIVE im dw r r 0)
      (plug-in-normalize RUN-NONINTERACTIVE im dw)

      ; save the composite
      (gimp-file-save RUN-NONINTERACTIVE im dw outFile outFile)
      (gimp-image-delete im)
   )
)
