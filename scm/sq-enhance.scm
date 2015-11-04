;
;   ____    _ __           ____               __    ____
;  / __/___(_) /  ___ ____/ __ \__ _____ ___ / /_  /  _/__  ____
; _\ \/ __/ / _ \/ -_) __/ /_/ / // / -_|_-</ __/ _/ // _ \/ __/
;/___/\__/_/_.__/\__/_/  \___\_\_,_/\__/___/\__/ /___/_//_/\__(_)
;
;Copyright 2008 SciberQuest Inc.
;

(define
  (sq-enhance inFile outFile)
    (let*
      (
      ; load background the im
      (im (car (gimp-file-load RUN-NONINTERACTIVE inFile inFile)))
      (dw (car (gimp-image-get-active-layer im)))
      (la 0) ; duplicated layer for mask
      (lm 0) ; mask
      )

      ; 
      (gimp-layer-add-alpha dw)
      (plug-in-cartoon RUN-NONINTERACTIVE im dw 5 0.01)
      (plug-in-unsharp-mask RUN-NONINTERACTIVE im dw 5 0.5 0)

      ; duplicate the layer
      ;(set! la (car (gimp-layer-new-from-drawable dw im)))
      (set! la (car (gimp-layer-copy dw 1)))
      (gimp-image-insert-layer im la 0 -1)

      ; make the mask
      (gimp-layer-add-alpha la)
      (gimp-desaturate-full la 0)
      (gimp-invert la)

      ; simple method appears slightly blurry and brighter compared
      ; to complicated method, overall very close.
      ; apply mask (simple)
      (gimp-layer-set-mode la 5)
      (gimp-layer-set-visible la 1)

      ; apply the mask (complicated)
      ;(set! lm (car (gimp-layer-create-mask la 5)))
      ;(gimp-layer-add-mask la lm)
      ;(gimp-layer-set-apply-mask la 1)
      ;(gimp-layer-set-mode la 5)
      ;(gimp-layer-set-visible la 1)

      ; save the composite
      (gimp-image-merge-visible-layers im  CLIP-TO-IMAGE)
      (set! dw (car (gimp-image-get-active-layer im)))
      (gimp-file-save RUN-NONINTERACTIVE im dw outFile outFile)
      (gimp-image-delete im)
   )
)

