;
;   ____    _ __           ____               __    ____
;  / __/___(_) /  ___ ____/ __ \__ _____ ___ / /_  /  _/__  ____
; _\ \/ __/ / _ \/ -_) __/ /_/ / // / -_|_-</ __/ _/ // _ \/ __/
;/___/\__/_/_.__/\__/_/  \___\_\_,_/\__/___/\__/ /___/_//_/\__(_)
;
;Copyright 2008 SciberQuest Inc.
;

(define
  (sq-axes inFile outFile xLow xHigh nMajorX nMinorX labelFreqX yLow yHigh nMajorY nMinorY labelFreqY majorWidth majorLength minorWidth minorLength tickPrecision tickFontFace tickFontSize tickFontColor xLabel yLabel labelFontFace labelFontSize labelFontColor figlet figletFontFace figletFontSize figletFontColor)
    (let*
      (
      (lf    0)    ; log file
      (x0    0)    ; x-axes start
      (x1    0)    ; x-axes end
      (axd   0)    ; delta for x-labels
      (y0    0)    ; y-axes start
      (y1    0)    ; y-axes end
      (ayd   0)    ; delta for y-labels
      (num   0)    ; axis label number
      (text  "")   ; label text
      (i     0)    ; loop variable
      (j     0)    ; loop variable
      (imw   0)    ; image width
      (imh   0)    ; image ht
      (lth   0)    ; large tick height
      (ltw   0)    ; large tick pen width
      (nltix 0)    ; number of large ticks
      (nltiy 0)    ; number of large ticks
      (sth   0)    ; small tick size
      (stw   0)    ; small tick pen width
      (nstix 0)    ; number of small ticks per large tick
      (nstiy 0)    ; number of small ticks per large tick
      (tlfx  0)    ; x tick label frequency
      (tlfy  0)    ; y tick label frequency
      (tprec 0)    ; tick precision
      (ytlx  0)    ; min y tick label x
      (lm    0)    ; left margin
      (rm    0)    ; right margin
      (tm    0)    ; top margin
      (bm    0)    ; bottom margin
      (tfpx  0)    ; tick font size px
      (lfpx  0)    ; label font size px
      (ifpx  0)    ; figlet font size px
      (fs    0)    ; font spacer
      (tl    0)    ; text layer
      (tw    0)    ; text width
      (th    0)    ; text height
      (x     0)    ; coord
      (y     0)    ; coord
      (xx    0)    ; coord
      (yy    0)    ; coord
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

      ; helper function find the position of the character
      ; in the string returns -1 if not found
      (define
        (find-char char str)
        (let* ( (i 0) (n 0) (j -1) )
          (set! n (string-length str))
          (while (< i n)
            (if (< j 0)
              (if (char=? (string-ref char 0) (string-ref str i)) (set! j i))
            )
            (set! i (+ i 1))
          )
          (if (< j 0) -1 j)
        )
      )

      ; helper function to do a very basic printf like
      ; fixed precision format output
      (define
        (sprintf prec num)
        (let* ( (str 0) (i 0) (j 0) (n 0) (c 0) (d 0) (out ""))
          (set! str (number->string num))
          (set! n (string-length str))
          (set! d (find-char "." str))
          (if (> prec 0)
            (begin
              (if (> d 0)
                ; trim and round input
                (begin
                  (set! i 0)
                  (while (<= i d)
                    (set! out (string-append out (string (string-ref str i))))
                    (set! i (+ i 1))
                  )
                  (set! j 0)
                  (while (and (< j (- prec 1)) (< i (- n 2)))
                    (set! out (string-append out (string (string-ref str i))))
                    (set! i (+ i 1))
                    (set! j (+ j 1))
                  )
                  (set! c (string->number (string (string-ref str i))))
                  (if (< (+ i 1) n)
                    ; number was long enough to convert with rounding
                    (begin
                      (set! d (string->number (string (string-ref str (+ i 1)))))
                      (if (= 1 (round (/ d 10.0)))
                        (set! c (+ c 1))
                      )
                      (set! out (string-append out (number->string c)))
                    )
                    ;else
                    ; number was too short to round
                    (begin
                      (set! out (string-append out (number->string c)))
                      ;(set! out (string-append out (number->string d)))
                    )
                  )
                  ; if it was too short then fill out with zeros
                  (set! j (+ j 1))
                  (while (< j prec)
                    (set! out (string-append out "0"))
                    (set! j (+ j 1))
                  )
                )
                ; else
                ; input was an integer add dec pt and zeros
                (begin
                  (set! out str)
                  (set! out (string-append out "."))
                  (set! i 0)
                  (while (< i prec)
                    (set! out (string-append out "0"))
                    (set! i (+ i 1))
                  )
                )
              )
            )
            ; else
            ; convert to an integer
            (begin
              (if (> d 0)
                ; input is not an integer
                (begin
                  (set! i 0)
                  (while (< i d)
                    (set! out (string-append out (string (string-ref str i))))
                    (set! i (+ i 1))
                  )
                )
                ; else
                ; already an integer just pass through
                (begin
                  (set! out str)
                )
              )
            )
          )
          out
        )
      )

      ; load the original
      (set! im (car (gimp-file-load RUN-NONINTERACTIVE inFile inFile)))
      (set! dw (car (gimp-image-get-active-layer im)))

      ; initialize parameters
      (set! imw (car (gimp-drawable-width dw)))
      (set! imh (car (gimp-drawable-height dw)))

      (set! tfpx (string->number tickFontSize))
      (set! lfpx (string->number labelFontSize))
      (set! ifpx (string->number figletFontSize))

      (set! nltix (string->number nMajorX))
      (set! nstix (string->number nMinorX))

      (set! x0 (string->number xLow))
      (set! x1 (string->number xHigh))
      (set! axd (/ (- x1 x0) (- nltix 1.0)))
      (set! tlfx (string->number labelFreqX))

      (set! nltiy (string->number nMajorY))
      (set! nstiy (string->number nMinorY))

      (set! y0 (string->number yLow))
      (set! y1 (string->number yHigh))
      (set! ayd (/ (- y1 y0) (- nltiy 1.0)))
      (set! tlfy (string->number labelFreqY))

      (set! lth (* tfpx (string->number majorLength)))
      (set! ltw (* tfpx (string->number majorWidth)))

      (set! sth (* tfpx (string->number minorLength)))
      (set! stw (* tfpx (string->number minorWidth)))

      (set! tprec (string->number tickPrecision))

      (set! fs  (* tfpx 0.1))

      (set! lm (* 10.0 tfpx))
      (set! rm (* 10.0 tfpx))
      (set! bm (* 10.0 tfpx))
      (set! tm (* 10.0 tfpx))

      (cond
        ((string=? tickFontColor "w")
          (gimp-context-set-background '(  0   0   0))
          (gimp-context-set-foreground '(255 255 255))
        )
        ((string=? tickFontColor "b")
          (gimp-context-set-background '(255 255 255))
          (gimp-context-set-foreground '(  0   0   0))
        )
        ((string=? tickFontColor "g")
          (gimp-context-set-background '(  0   0   0))
          (gimp-context-set-foreground '(145 145 145))
        )
      )

      ; resize
      (gimp-image-resize im (+ imw lm rm) (+ imh tm bm) lm tm)
      (gimp-layer-resize dw (+ imw lm rm) (+ imh tm bm) lm tm)

      ; add x-ticks
      (if (> nltix 0)
        (begin
          ; draw small ticks
          (set! dx (/ imw (- nltix 1.0)))
          (set! x lm)
          (set! y (+ imh tm))
          (set! i 0)
          (while (< i (- nltix 1))
            (set! xx x)
            (set! j 0)
            (while (< j nstix)
              (draw-line dw stw xx y xx (+ y sth))
              (set! xx (+ xx (/ dx (- nstix 1.0))))
              (set! j (+ j 1))
              )
            (set! x (+ x dx))
            (set! i (+ i 1))
          )

          ; draw large ticks
          (set! x lm)
          (set! i 0)
          (while (< i nltix)
            (draw-line dw ltw x y x (+ y lth))
            (set! x (+ x dx))
            (set! i (+ i 1))
          )

          ; draw axis line
          (draw-line dw ltw lm y (+ lm imw) y)

          ; draw tick labels
          (set! x lm)
          (set! y (+ imh tm lth fs))
          (set! i 0)
          (while (< i nltix)
            (if (= (modulo i tlfx) 0)
              (begin
                (set! text (sprintf tprec (+ x0 (* i axd))))
                (set! tw (* (string-length text) tfpx))
                (set! th tfpx)
                (gimp-floating-sel-to-layer
                  (car
                    (gimp-text-fontname
                        im
                        dw
                        (- x (/ tw 2.0))
                        y
                        text
                        0
                        TRUE
                        tfpx
                        PIXELS
                        tickFontFace)
                  )
                )
                (set! tl (car (gimp-image-get-active-layer im)))
                (set! tw (car (gimp-drawable-width tl)))
                (set! th (car (gimp-drawable-height tl)))
                (gimp-layer-set-offsets tl (- x (/ tw 2.0)) y)
              )
            )

            (set! x (+ x dx))
            (set! i (+ i 1))
          )
        )
      )

      ; add y-ticks
      (if (> nltiy 0)
        (begin
            ; draw small ticks
            (set! dy (/ imh (- nltiy 1.0)))
            (set! x (- lm sth))
            (set! y tm)
            (set! i 0)
            (while (< i (- nltiy 1))
              (set! yy y)
              (set! j 0)
              (while (< j nstiy)
                (draw-line dw stw x yy  (+ x sth) yy)
                (set! yy (+ yy (/ dy (- nstiy 1.0))))
                (set! j (+ j 1))
              )
              (set! y (+ y dy))
              (set! i (+ i 1))
            )

            ; draw large ticks
            (set! x (- lm lth))
            (set! y tm)
            (set! i 0)
            (while (< i nltiy)
              (draw-line dw ltw x y (+ x lth) y)
              (set! y (+ y dy))
              (set! i (+ i 1))
            )

            ; draw axis line
            (draw-line dw ltw lm tm lm (+ tm imh))

            ; draw tick labels
            (set! ytlx imw)
            (set! x (- lm lth fs))
            (set! y tm)
            (set! i (- nltiy 1))
            (while (>= i 0)
              (if (= (modulo i tlfy) 0)
                (begin
                  (set! text (sprintf tprec (+ y0 (* i ayd))))
                  (set! tw (* (string-length text) tfpx))
                  (set! th tfpx)
                  (gimp-floating-sel-to-layer
                    (car
                      (gimp-text-fontname
                          im
                          dw
                          (- x tw)
                          (- y (/ th 2.0))
                          text
                          0
                          TRUE
                          tfpx
                          PIXELS
                          tickFontFace)
                    )
                  )
                  (set! tl (car (gimp-image-get-active-layer im)))
                  (set! tw (car (gimp-drawable-width tl)))
                  (set! th (car (gimp-drawable-height tl)))
                  (gimp-layer-set-offsets tl (- x tw) (- y (/ th 2.0)))

                  (if (< (- x tw) ytlx) (set! ytlx (- x tw)))
                )
              )

              (set! y (+ y dy))
              (set! i (- i 1))
            )
          )
        )


      ; draw axis labels
      (cond
        ((string=? labelFontColor "w")
          (gimp-context-set-background '(  0   0   0))
          (gimp-context-set-foreground '(255 255 255))
        )
        ((string=? labelFontColor "b")
          (gimp-context-set-background '(255 255 255))
          (gimp-context-set-foreground '(  0   0   0))
        )
        ((string=? labelFontColor "g")
          (gimp-context-set-background '(  0   0   0))
          (gimp-context-set-foreground '(145 145 145))
        )
      )

      (if (not (string=? xLabel ""))
        (begin
          ; draw x-label
          (gimp-floating-sel-to-layer
            (car
              (gimp-text-fontname
                  im
                  dw
                  (/ imw 2.0)
                  (/ imh 2.0)
                  xLabel
                  0
                  TRUE
                  lfpx
                  PIXELS
                  labelFontFace)
            )
          )
          (set! tl (car (gimp-image-get-active-layer im)))
          (set! tw (car (gimp-drawable-width tl)))
          (set! th (car (gimp-drawable-height tl)))
          (set! x (- (+ lm (/ imw 2.0)) (/ tw 2.0)))
          (set! y (+ tm imh lth fs fs lfpx))
          (gimp-layer-set-offsets tl x y)
        )
      )

      ; draw y-label
      (if (not (string=? yLabel ""))
        (begin
          (gimp-floating-sel-to-layer
            (car
              (gimp-text-fontname
                  im
                  dw
                  (/ imw 2.0)
                  (/ imh 2.0)
                  yLabel
                  0
                  TRUE
                  lfpx
                  PIXELS
                  labelFontFace)
            )
          )
          (set! tl (car (gimp-image-get-active-layer im)))
          (gimp-drawable-transform-rotate-simple tl ROTATE-270 TRUE 0 0 FALSE)
          (set! tw (car (gimp-drawable-width tl)))
          (set! th (car (gimp-drawable-height tl)))
          (set! x (- ytlx fs fs tw))
          (set! y (- (+ tm (/ imh 2.0)) (/ th 2.0)))
          (gimp-layer-set-offsets tl x y)
          (set! ytlx x)
        )
      )

      ; draw figlet
      (cond
        ((string=? figletFontColor "w")
          (gimp-context-set-background '(  0   0   0))
          (gimp-context-set-foreground '(255 255 255))
        )
        ((string=? figletFontColor "b")
          (gimp-context-set-background '(255 255 255))
          (gimp-context-set-foreground '(  0   0   0))
        )
        ((string=? figletFontColor "g")
          (gimp-context-set-background '(  0   0   0))
          (gimp-context-set-foreground '(145 145 145))
        )
      )

      (if (not (string=? figlet ""))
        (begin
          (gimp-floating-sel-to-layer
            (car
              (gimp-text-fontname
                  im
                  dw
                  (/ imw 2.0)
                  (/ imh 2.0)
                  figlet
                  0
                  TRUE
                  ifpx
                  PIXELS
                  figletFontFace)
            )
          )
          (set! tl (car (gimp-image-get-active-layer im)))
          (set! tw (car (gimp-drawable-width tl)))
          (set! th (car (gimp-drawable-height tl)))
          (if (> nltiy 0)
            (begin
              (set! x (- ytlx tw))
              (set! y (+ tm ifpx))
            )
          ;else
            (begin
              (set! x (- lm tw fs))
              (set! y (+ tm imh lth fs fs lfpx lfpx))
            )
          )
          (gimp-layer-set-offsets tl x y)
        )
      )

      ; flatten
      (gimp-image-merge-visible-layers im  CLIP-TO-IMAGE)
      (set! dw (car (gimp-image-get-active-layer im)))

      ; add a white background
      (set! dw (car (gimp-image-get-active-layer im)))
      (set! imw (car (gimp-drawable-width dw)))
      (set! imh (car (gimp-drawable-height dw)))
      (set! dw (car (gimp-layer-new im imw imh RGB-IMAGE "bg" 100 NORMAL-MODE)))
      (gimp-image-add-layer im dw 1)
      (gimp-drawable-fill dw WHITE-FILL)
      ;(gimp-image-lower-layer-to-bottom im dw)

      ; flatten
      (gimp-image-merge-visible-layers im  CLIP-TO-IMAGE)
      (set! dw (car (gimp-image-get-active-layer im)))

      ; auto-crop
      (plug-in-autocrop RUN-NONINTERACTIVE im dw)

      ; save the annotated image
      (gimp-file-save RUN-NONINTERACTIVE im dw outFile outFile)
      (gimp-image-delete im)
   )
)
