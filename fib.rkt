#lang racket

(define (Fib n)
  (if (<= n 1) n
      (+ (Fib (- n 1)) (Fib (- n 2)))))

(define (Fibr n)
  (define (Fibr/helper n prev pprev)
    (cond
      [(= n 0) pprev]
      [else
       (let ([next (+ pprev prev)])
            (Fibr/helper (sub1 n) next prev))]))
  (Fibr/helper n 1 0))

(require "ch3.rkt")

(define memo-fib (my-memo Fibr))

(define (binet-fib n)
  (let* ([phi (/ (add1 (sqrt 5)) 2)]
         [phi^n (expt phi n)])
    (round (/ phi^n (sqrt 5)))))
