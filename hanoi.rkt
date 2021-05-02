#lang racket

(define (hanoi n f t)
  (if (= n 1) (list (list f t)) ; Return a list of one move, f to t
      (let* ([u (- 3 (+ f t))] ; Next peg to move to
             [m1 (hanoi (sub1 n) f u)] ; Move n-1 disks to intermediate
             [m2 (list f t)] ; Move from to t
             [m3 (hanoi (sub1 n) u t)]) ; Move intermediate to t
        (append m1 (cons m2 m3))))) ; Return the appended list of moves.
