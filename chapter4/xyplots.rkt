#lang racket
(require plot)

(plot (function sin #:color "Blue")
      #:x-min (* -2 pi) #:x-max (* 2 pi)
      #:title "The Sine Function")

(plot (list
       (axes) ; can also use (axis x y) to specify location
       (function sin #:color "Blue" #:label "sin" #:style 'dot)
       (function cos 0 (* 2 pi) #:color "red" #:label "cos"))
      #:x-min (* -2 pi) #:x-max (* 2 pi)
      #:y-min -2 #:y-max 2
      #:title "Sine and Cosine"
      #:x-label "X"
      #:y-label #f) ; suppress y label

(plot (list (axes)
            (function sin #:color "Blue" #:label "sin" #:style 'dot)
            (inverse sqr -2 2 #:color "Red" #:label "x^2" #:width 2))
      #:x-min (* -2 pi) #:x-max (* 2 pi)
      #:y-min -2 #:y-max 2
      #:title "Sine and Square"
      #:x-label "X"
      #:y-label #f
      #:legend-anchor 'bottom-left)
