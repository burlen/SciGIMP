;    ____    _ ___________  ______
;   / __/___(_) ___/  _/  |/  / _ \
;  _\ \/ __/ / (_ // // /|_/ / ___/
; /___/\__/_/\___/___/_/  /_/_/
;
; Copyright 2014 Burlen Loring

(define
  (sq-pack-stereo-tb leftFile rightFile outFile halfRes)
    (let*
      (
      (im   0)
      (dw   0)
      (dwL  0)
      (dwR  0)
      (w    0)
      (h    0)
      (hh   0)
      )
      (gimp-message-set-handler ERROR-CONSOLE)

      ; determine output size
      (set! w 1920)
      (set! h 1080)
      (if (not (equal? (string->number halfRes) 0))
      (begin
        (set! h 1080)
      )
      ; else
      (begin
        (set! h 2160)
      ))
      (set! hh (/ h 2.0))

      ; create the new image
      (set! im (car (gimp-image-new w h RGB)))

      ; load, scale, position left
      (set! dwL (car (gimp-file-load-layer RUN-NONINTERACTIVE im leftFile)))
      (gimp-image-add-layer im dwL -1)
      (gimp-layer-scale-full dwL w hh TRUE INTERPOLATION-LANCZOS)
      (gimp-layer-set-offsets dwL 0 0)

      ; load, scale, position right
      (set! dwR (car (gimp-file-load-layer RUN-NONINTERACTIVE im rightFile)))
      (gimp-image-add-layer im dwR -1)
      (gimp-layer-scale-full dwR w hh TRUE INTERPOLATION-LANCZOS)
      (gimp-layer-set-offsets dwR 0 hh)

      ; save the composite
      (gimp-image-merge-visible-layers im  CLIP-TO-IMAGE)
      (set! dw (car (gimp-image-get-active-layer im)))
      (gimp-file-save RUN-NONINTERACTIVE im dw outFile outFile)
   )
)
