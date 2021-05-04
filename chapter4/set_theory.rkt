#lang racket
(require racket/draw)

(define WIDTH 150)
(define HEIGHT 100)

(define venn (make-bitmap WIDTH HEIGHT))
(define dc (new bitmap-dc% [bitmap venn]))

(send dc scale 1.0 -1.0)
(send dc translate (/ WIDTH 2) (/ HEIGHT -2))

(send dc set-smoothing 'smoothed)
(send dc set-pen "black" 2 'solid)

(define IN-BRUSH (new brush% [color "green"]))
(define OUT-BRUSH (new brush% [color (make-object color% 220 220 220)]))
(define SET-BRUSH (new brush% [color (make-object color% 220 255 220)]))

(define CIRCLE-OFF 20)

(define (rect x y w h b)
  (let ([x (- x (/ w 2))]
        [y (- y (/ h 2))])
    (send dc set-brush b)
    (send dc draw-rectangle x y w h)))

(define (circle x y r b)
  (let ([x (- x r)]
        [y (- y r)])
    (send dc set-brush b)
    (send dc draw-ellipse x y (* 2 r) (* 2 r))))

(define (universe b) (rect 0 0 (- WIDTH 10) (- HEIGHT 10) b))

(define (piscis x y r b)
  (let* ([y (- y r)]
         [2r (* 2 r)]
         [yi (sqrt (- (sqr r) (sqr x)))]
         [phi (asin (/ yi r))]
         [th (- pi phi)]
         [path (new dc-path%)])
    (send dc set-brush b)
    (send path move-to 0 (- yi))
    (send path arc (- x r) y 2r 2r th (+ pi phi))
    (send path arc (- (- x) r) y 2r 2r (- phi) phi)
    (send dc draw-path path)))

(define (venn-bin b1 b2 b3)
  (universe OUT-BRUSH)
  (circle (- CIRCLE-OFF) 0 30 b1)
  (circle CIRCLE-OFF 0 30 b3)
  (piscis CIRCLE-OFF 0 30 b2)
  (print venn))

;; Illustrate with sets

(define A (set 2 4 6 8 10 12 14 16 18))
(define B (set 3 6 9 12 15 18))

(define ab-union (set-union A B))

; cartesian-product
(define (cart-prod A B)
  (list->set
   (for*/list ([a A]
               [b B]) (list a b))))
