#lang racket
(require racket/draw)

(define drawing (make-bitmap 50 50))
(define dc (new bitmap-dc% [bitmap drawing]))

(send dc set-pen "black" 2 'solid)

(send dc draw-line 10 10 30 25)
(send dc draw-rectangle 0 0 50 25)
(send dc draw-ellipse 10 10 30 25)
