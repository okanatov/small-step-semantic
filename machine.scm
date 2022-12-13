#lang racket

(require "showable.scm" "reducible.scm")

(provide machine-step)

(define (machine-step expr env)
  (begin
    (displayln (show expr))
    (cond
      [(can-be-reduced expr) (let*
			       ([frame (reduce expr env)])
			       (machine-step (car frame) (cdr frame)))]
      [else (cons expr env)])))

