#lang racket
(require racket/draw)

(define WIDTH 300)
(define HEIGHT 110)
(define nim-board (make-bitmap WIDTH HEIGHT))
(define dc (new bitmap-dc% [bitmap nim-board]))

(define BOTTOM-MARGIN 20)


(define RADIUS 8)
(define DIAMETER (* 2 RADIUS))
(define DELTA-Y (- (* DIAMETER (sin (/ pi 3)))))

(define BOARD-THICKNESS 10)
(define BOARD-Y (- HEIGHT BOARD-THICKNESS BOTTOM-MARGIN))

;; Location to start drawing pile numbers
(define TEXT-X (+ 5 (* RADIUS 5)))
(define TEXT-Y (- HEIGHT BOTTOM-MARGIN))

; x,y to start drawing balls
(define START-X 20)
(define START-Y (- BOARD-Y RADIUS))

(define BALL-BRUSH (new brush% [color "red"]))
(define BACKGROUND-BRUSH (new brush% [color "yellow"]))
(define BOARD-BRUSH (new brush% [color "brown"]))

;; Begin Game Drawing Functions

(define (draw-ball dc x y)
  (send dc draw-ellipse (- x RADIUS) (- y RADIUS) DIAMETER DIAMETER))

(define (draw-pile dc n start-x)
  (let ([rem n]
        [x start-x]
        [y START-Y])
    (define (draw-row x y n max)
      (when (and (> rem 0) (<= n max))
        (set! rem (sub1 rem))
        (draw-ball dc x y)
        (draw-row (+ x DIAMETER) y (add1 n) max)))
    (for ([r (in-range 5 0 -1)])
      (draw-row x y 1 r)
      (set! x (+ x RADIUS))
      (set! y (+ y DELTA-Y)))))

(define pile (make-vector 3 15))

(define (draw-game dc)
  (send dc set-pen "black" 2 'solid)
  (send dc set-brush BACKGROUND-BRUSH)
  (send dc draw-rectangle 0 0 WIDTH HEIGHT)

  (send dc set-brush BOARD-BRUSH)
  (send dc draw-rectangle 0 BOARD-Y WIDTH BOARD-THICKNESS)

  (send dc set-brush BALL-BRUSH)

  (draw-pile dc (vector-ref pile 0) START-X)
  (send dc draw-text "0" TEXT-X TEXT-Y)

  (draw-pile dc (vector-ref pile 1) (+ START-X (* 6 DIAMETER)))
  (send dc draw-text "1" (+ TEXT-X (* 6 DIAMETER)) TEXT-Y)

  (draw-pile dc (vector-ref pile 2) (+ START-X (* 12 DIAMETER)))
  (send dc draw-text "2" (+ TEXT-X (* 12 DIAMETER)) TEXT-Y))

(define (draw-and-print)
  (draw-game dc)
  (print nim-board))

(draw-and-print)

;; Begin AI Functions
(define nim-sum bitwise-xor)

(define (random-pile)
  (for/first ([i (let ([start (random 3)])
                   (in-range start (+ start 3)))])
    (let ([idx (remainder i 3)])
      (when (> (vector-ref pile idx) 0) idx))))

(define (find-move)
  (let* ([balls (vector->list pile)]
         [s (apply nim-sum balls)])
    (if (= 0  s)
        (let ([i (random-pile)]) (values i 1)) ;; stall
        (let ([n (list->vector (map (λ (b) (nim-sum s b)) balls))])
          (define (test? i) (< (vector-ref n i) (vector-ref pile i)))
          (define (move i) (values i (- (vector-ref pile i) (vector-ref n i))))
          (cond [(test? 0) (move 0)]
                [(test? 1) (move 1)]
                [(test? 2) (move 2)])))))

;; Player move functions
(define (apply-move p n)
  (vector-set! pile p (- (vector-ref pile p) n)))

(define (game-over?)
  (for/and ([i (in-range 3)]) (= 0 (vector-ref pile i))))

(define (valid-move? p n)
  (cond [(not (<= 0 p 2)) #f]
        [(< n 0) #f]
        [else (>= (vector-ref pile p)) n]))

(define (move p n)
  (if (not (valid-move? p n))
      (printf "\nInvalid move.\n\n")
      (begin (apply-move p n)
             (if (game-over?)
                 (printf "\nYou Win!")
                 (let-values ([(p n) (find-move)])
                   (draw-and-print)
                   (printf "\n\nComputer removes ~a balls from pile ~a.\n" n p)
                   (apply-move p n)
                   (draw-and-print)
                   (when (game-over?)
                     (printf "\nComputer Wins lol!")))))))

(define (init)
  (for ([ i (in-range 3)]) (vector-set! pile i (random 10 16)))
  (newline)
  (draw-and-print)
  (newline))
