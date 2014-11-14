;    ____    _ ___________  ______
;   / __/___(_) ___/  _/  |/  / _ \
;  _\ \/ __/ / (_ // // /|_/ / ___/
; /___/\__/_/\___/___/_/  /_/_/
;
; Copyright 2014 Burlen Loring
(define
  (sq-scale inFile outFile widthFac heightFac)
    (let*
      (
      (imw  0)    ; image width
      (imh  0)    ; image ht
      (wf   0)    ; scaling in percent of original width
      (hf   0)    ; scaling in percent of original height
      (simw 0)    ; scaled image width
      (simh 0)    ; sclaled image height
      (im   0)    ; image
      (dw   0)    ; drawable
      )

      (set! im (car (gimp-file-load RUN-NONINTERACTIVE inFile inFile)))
      (set! dw (car (gimp-image-get-active-layer im)))

      (set! imw (car (gimp-drawable-width dw)))
      (set! imh (car (gimp-drawable-height dw)))

      (set! wf (string->number widthFac))
      (set! hf (string->number heightFac))

      (set! simw (* wf imw))
      (set! simh (* hf imh))

      (gimp-image-scale-full im simw simh INTERPOLATION-LANCZOS)

      ;(gimp-image-merge-visible-layers im  CLIP-TO-IMAGE)
      ;(set! dw (car (gimp-image-get-active-layer im)))
      (gimp-file-save RUN-NONINTERACTIVE im dw outFile outFile)
      (gimp-image-delete im)
   )
)
