;
;   ____    _ __           ____               __    ____
;  / __/___(_) /  ___ ____/ __ \__ _____ ___ / /_  /  _/__  ____
; _\ \/ __/ / _ \/ -_) __/ /_/ / // / -_|_-</ __/ _/ // _ \/ __/
;/___/\__/_/_.__/\__/_/  \___\_\_,_/\__/___/\__/ /___/_//_/\__(_)
;
;Copyright 2008 SciberQuest Inc.
;

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
