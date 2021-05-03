#lang racket
(require plot)

(define phi (/ (add1 (sqrt 5)) 2))

(plot (polar (λ (t) (expt phi (* t (/ 2 pi))))
             0 (* 4 pi)
             #:x-min -20 #:x-max 50
             #:y-min -40 #:y-max 30
             #:color "red")
      #:title "Golden Spiral"
      #:x-label #f #:y-label #f)
