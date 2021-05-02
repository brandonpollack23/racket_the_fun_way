#lang racket
(require math/number-theory)

(define (gen-triples prod)
  (define (gen-triples/helper d1 triples)
    (let* ([q (/ prod d1)]
           [divs (divisors q)])
      (define (try-div divs triples)
        (if (not (null? divs))
            (let* ([d2 (car divs)]
                 [d3 (/ q d2)]
                 [new-triples (cons `(,d3 ,d2 ,d1) triples)])
              (try-div (cdr divs) new-triples))
            triples))
      (try-div divs '())))
  (apply append (for/list ([d (divisors prod)]) (gen-triples/helper d '()))))

(define triples (gen-triples 36))
  

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
