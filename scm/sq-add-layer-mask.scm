;    ____    _ ___________  ______
;   / __/___(_) ___/  _/  |/  / _ \
;  _\ \/ __/ / (_ // // /|_/ / ___/
; /___/\__/_/\___/___/_/  /_/_/
;
; Copyright 2016 Burlen Loring

(define
  (sq-add-layer-mask inFile maskFile outFile)
    (let*
      (
      (im   0)
      (dw   0)
      (mdw  0)
      (m    0)
      )

      ; load the original
      (set! im (car (gimp-file-load RUN-NONINTERACTIVE inFile inFile)))
      (set! dw (car (gimp-image-get-active-layer im)))
      (gimp-layer-add-alpha dw)

      ; load the mask image
      (set! mdw (car (gimp-file-load-layer RUN-NONINTERACTIVE im maskFile)))
      (gimp-image-insert-layer im mdw 0 -1)

      ; create the mask
      (set! m (car (gimp-layer-create-mask mdw ADD-COPY-MASK)))
      (gimp-layer-add-mask dw m)
      (gimp-item-set-visible mdw FALSE)

      ; save the masked image
      (gimp-image-merge-visible-layers im  CLIP-TO-IMAGE)
      (set! dw (car (gimp-image-get-active-layer im)))
      (gimp-file-save RUN-NONINTERACTIVE im dw outFile outFile)
    )
)
