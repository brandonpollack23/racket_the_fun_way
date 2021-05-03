#lang at-exp racket

(require infix plot)

(define r 30)

(define (cycloid t) @${vector[r*(t-sin[t]), r*(1-cos[t])]})

(plot (list
       (axes)
       (parametric cycloid 0 (* 2 pi)
                   #:color "red"
                   #:samples 1000))
      #:x-min 0 #:x-max (* r 2 pi)
      #:y-min 0 #:y-max (* r 2 pi))
