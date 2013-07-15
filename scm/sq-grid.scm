;
;   ____    _ __           ____               __    ____
;  / __/___(_) /  ___ ____/ __ \__ _____ ___ / /_  /  _/__  ____
; _\ \/ __/ / _ \/ -_) __/ /_/ / // / -_|_-</ __/ _/ // _ \/ __/
;/___/\__/_/_.__/\__/_/  \___\_\_,_/\__/___/\__/ /___/_//_/\__(_)
;
;Copyright 2008 SciberQuest Inc.
;

(define
  (sq-grid inFile outFile nMajorX nMajorY lineWidth lineLength lineSkip lineColor)
    (let*
      (
      (i     0)    ; loop variable
      (j     0)    ; loop variable
      (imw   0)    ; image width
      (imh   0)    ; image ht
      (nltix 0)    ; number of large ticks
      (nltiy 0)    ; number of large ticks
      (gsw   0)    ; grid segment width
      (gsl   0)    ; grid segment height
      (gss   0)    ; grid segment skip
      (g0    0)    ; grid coord
      (g1    0)    ; grid coord
      (g2    0)    ; grid coord
      (x     0)    ; coord
      (y     0)    ; coord
      (dx    0)    ; delta
      (dy    0)    ; delta
      (im    0)    ; image
      (dw    0)    ; drawable
      )

      ; helper function set a brush of the requested width
      ; and draw a line between the requested poiints
      (define
        (draw-line dw w x0 y0 x1 y1)
        (let* ( (pts 0) (br 0))
          (set! br (car (gimp-brush-new "tmpbr")))
          (gimp-brush-set-shape br BRUSH-GENERATED-SQUARE)
          (gimp-brush-set-radius br w)
          (gimp-context-set-brush br)
          (set! pts (cons-array 4 'double))
          (aset pts 0 x0)
          (aset pts 1 y0)
          (aset pts 2 x1)
          (aset pts 3 y1)
          (gimp-pencil dw 4 pts)
          (gimp-brush-delete br)
        )
      )

      ; load the original
      (set! im (car (gimp-file-load RUN-NONINTERACTIVE inFile inFile)))
      (set! dw (car (gimp-image-get-active-layer im)))

      ; initialize parameters
      (set! imw (car (gimp-drawable-width dw)))
      (set! imh (car (gimp-drawable-height dw)))

      (set! nltix (string->number nMajorX))
      (set! nltiy (string->number nMajorY))

      (set! gsl (string->number lineLength))
      (set! gsw (string->number lineWidth))
      (set! gss (string->number lineSkip))

      (cond
        ((string=? lineColor "w")
          (gimp-context-set-background '(  0   0   0))
          (gimp-context-set-foreground '(255 255 255))
        )
        ((string=? lineColor "b")
          (gimp-context-set-background '(255 255 255))
          (gimp-context-set-foreground '(  0   0   0))
        )
        ((string=? lineColor "g")
          (gimp-context-set-background '(  0   0   0))
          (gimp-context-set-foreground '(145 145 145))
        )
        ((string=? lineColor "dg")
          (gimp-context-set-background '(  0   0   0))
          (gimp-context-set-foreground '(80 80 80))
        )
      )

      ; add vertical grid lines
      (if (> nltix 0)
        (begin
          (set! dx (/ imw (- nltix 1.0)))
          (if (> gsl 0)
            (begin
              (set! x 0)
              (set! x (+ x dx))
              (set! i 1)
              (while (< i (- nltix 1))
                (set! g0 0)
                (set! g2 (- imh (* gsw 2)))
                (while (< g0 g2)
                  (set! g1 (+ g0 gsl))
                  (if (> g1 g2) (set! g1 g2))
                  (draw-line dw gsw x g0 x g1)
                  (set! g0 (+ g1 (* gss gsl)))
                )
                (set! x (+ x dx))
                (set! i (+ i 1))
              )
            )
          )
        )
      )

      ; horizontal grid lines
      (if (> nltiy 0)
        (begin
          (set! dy (/ imh (- nltiy 1.0)))
          (if (> gsl 0)
            (begin
              (set! y 0)
              (set! y (+ y dy))
              (set! i 1)
              (while (< i (- nltiy 1))
                (set! g0 0)
                (set! g2 (- imw (* gsw 2)))
                (while (< g0 g2)
                  (set! g1 (+ g0 gsl))
                  (if (> g1 g2) (set! g1 g2))
                  (draw-line dw gsw g0 y g1 y)
                  (set! g0 (+ g1 (* gss gsl)))
                  )
                (set! y (+ y dy))
                (set! i (+ i 1))
              )
            )
          )
        )
      )

      ; save the annotated image
      (gimp-file-save RUN-NONINTERACTIVE im dw outFile outFile)
      (gimp-image-delete im)
   )
)
