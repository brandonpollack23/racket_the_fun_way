#lang racket
(require plot)

(parameterize ([plot-width 250]
               [plot-height 250]
               [plot-x-label #f]
               [plot-y-label #f])
  (define lim 30)
  (plot (list
         (points '(#(0 0))
                 #:size 300
                 #:sym 'fullcircle1
                 #:color "black"
                 #:fill-color "yellow")
         (points '(#(-5 5) #(5 5))
                 #:size 10
                 #:fill-color "black")
         (points '(#(0 -5))
                 #:size 30
                 #:sym 'fullcircle1
                 #:color "black"
                 #:fill-color "black"))
        #:x-min (- lim) #:x-max (+ lim)
        #:y-min (- lim) #:y-max (+ lim)))
