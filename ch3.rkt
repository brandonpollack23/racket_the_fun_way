#lang racket

(define (fact-shit n)
  (if (= 0 n) 1
      (* n (fact (- n 1)))))

(define fact
  (let ([h (make-hash)])
    (define (fact n)
      (cond
        [(= n 0) 1 ]
        [(hash-has-key? h n) (hash-ref h n)]
        [else (let ([f (* n (fact (- n 1)))])
                (hash-set! h n f)
                f)]))
    fact))

(define (my-memo fun)
  (let ([h (make-hash)])
    (define (inner-fun . args)
      (cond
        [(hash-has-key? h args) (hash-ref h args)]
        [else (let ([result (apply fun args)])
                (hash-set! h args result)
                result)]))
    inner-fun))

(define smarter-fact (my-memo fact-shit))
