#lang racket

(define queue%
  (class object%
    (init [queue-list '()])
    (define head '{})
    (define tail '{})

    (super-new)

    (define/public (enqueue val)
      (let ([t (mcons val '())])
        (if (null? head)
            (begin
              (set! head t)
              (set! tail t))
            (begin
                  (set-mcdr! tail t)
                  (set! tail t)))))

    (define/public (dequeue)
      (if (null? head) (error "Queue is empty!")
          (let ([val (mcar head)])
            (set! head (mcdr head))
            (when (null? head) (set! tail '()))
            val)))

    (define/public (print-queue)
      (define (prt rest)
        (if (null? rest)
            (newline)
            (let ([h (mcar rest)]
                  [t (mcdr rest)])
              (printf "~a " h)
              (prt t))))
      (prt head))

    (for ([v queue-list]) (enqueue v))))
