#lang racket

(require "showable.scm" "reducible.scm")

(provide machine-step)

(define (machine-step expr)
  (begin
    (displayln (show expr))
    (cond
      [(can-be-reduced expr) (machine-step (reduce expr))]
      [else expr])))

