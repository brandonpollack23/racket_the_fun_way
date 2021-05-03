#lang racket
(require plot)

(plot (function sin #:color "Blue")
      #:x-min (* -2 pi) #:x-max (* 2 pi)
      #:title "The Sine Function")
