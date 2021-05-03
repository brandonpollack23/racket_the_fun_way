#lang racket
(require plot)

(define pts (for/list ([i (in-range 0 6)]) (vector i (sqr i))))

(plot (list
       (lines pts
              #:width 2
              #:color "Green")
       (points pts
               #:sym 'fulldiamond
               #:color "red"
               #:fill-color "red"))
      #:x-min -0.5 #:x-max 5.5
      #:y-min -0.5 #:y-max 26)
