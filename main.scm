#lang racket

(require "showable.scm" "reducible.scm" "add.scm" "multiply.scm" "number.scm")

(define expr (Add
	       (Multiply (Number 1) (Number 2))
	       (Multiply (Number 3) (Number 4))))

(define (step expr)
  (begin
    (displayln (show expr))
    (cond
      [(can-be-reduced expr) (step (reduce expr))]
      [else expr])))

(step expr)
