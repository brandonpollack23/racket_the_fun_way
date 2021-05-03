#lang at-exp racket

(require infix plot)

(define r 30)
(define off (+ 5 (* 2 r)))


; albebraic half circles
(define (c1 x) @${sqrt[r^2 - x^2]})
(define (c2 x) @${-sqrt[r^2 - x^2]})

; parametric circle
(define (cp t) @${vector[off + r*cos[t], r*sin[t]]})

(plot (list
       (axes)
       ; Albebraic
       (function c1 (- r) r #:color "blue" #:label "c1")
       (function c2 (- r) r #:style 'dot #:label "c2")
       ;parametric
       (parametric cp 0 (* 2 pi) #:color "red" #:label "cp" #:width 2))
      #:x-min (- r) #:x-max (+ off r)
      #:y-min (- r) #:y-max (+ off r)
      #:legend-anchor 'top-right)
