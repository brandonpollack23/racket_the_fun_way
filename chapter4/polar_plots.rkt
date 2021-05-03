#lang at-exp racket
(require infix plot)

(parameterize
    ([plot-width 150]
     [plot-height 150]
     [plot-tick-size 0]
     [plot-font-size 0]
     [plot-x-label #f]
     [plot-y-label #f])
  (list (plot (polar (λ (θ) 1) 0 (* 2 pi))
              #:x-min -1 #:x-max 1
              #:y-min -1 #:y-max 1)
        (plot (polar (λ (θ) θ) 0 (* 5 pi))
              #:x-min -8 #:x-max 8
              #:y-min -8 #:y-max 8)
        (plot (list
               (polar-axes #:number 8)
               (polar (λ (t) @${sin[2*t]}) 0 (* 2 pi)
                      #:x-min -1 #:x-max 1
                      #:y-min -1 #:y-max 1)))))
(define (rose k)
  (plot (list
         (polar (λ (t) @${sin[k*t]}) 0 (* 4 pi)
                #:x-min -1 #:x-max 1
                #:y-min -1 #:y-max 1))))

(for/list ([k '(1 1.5 2 2.5 3 4 5)]) (rose k))
