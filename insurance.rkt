#lang racket
(require math/number-theory)

(define triples '())
(define (gen-triples d1)
  (let* ([q (/ 36 d1)]
         [divs (divisors q)])
    (define (try-div divs)
      (when (not (null? divs))
        (let* ([d2 (car divs)]
               [d3 (/ q d2)])
          (set! triples (cons `(,d3 ,d2 ,d1) triples)))
        (try-div (cdr divs))))
    (try-div divs)))

(for ([d (divisors 36)]) (gen-triples d))

;; (for ([triple triples]) (printf "~a: ~a\n" triple (apply + triple)))

(define (largest-is-unique ls)
  (let* ([grouped (group-by identity ls)]
         [sorted (reverse (sort grouped #:key (λ (x) (car x)) <))]
         [largest-length (length (car sorted))])
    (= 1 largest-length)))

(define (sum-is ls x)
  (= x (apply + ls)))

(for/first ([triple triples]
            #:when (and (sum-is triple 13) (largest-is-unique triple))) triple)
