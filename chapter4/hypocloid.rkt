#lang at-exp racket
(require infix plot)

(define r 20)
(define R (* r 3))

(define (hypocloid phi)
  @${vector[
              (R - r)*cos[phi] + r*cos[(R - r)/r * phi],
              (R - r)*sin[phi] - r*sin[(R - r)/r * phi]
              ]})

(plot (list
       ;; Outer Circle
       (parametric (λ (t) @${vector[R*cos[t], R*sin[t]]})
                   0 (* r 2 pi)
                   #:color "Black"
                   #:width 2)
       (parametric hypocloid 0 (* r 2 pi)
                   #:color "Red"
                   #:width 2))
      #:x-min (- -10 R ) #:x-max (+ 10 R )
      #:y-min (- -10 R ) #:y-max (+ 10 R )
      #:x-label #f #:y-label #f)
