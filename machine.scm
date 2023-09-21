#lang racket

(require "operations.scm" "tags.scm")

(provide run)

(define (step expr)
  (reduce expr))

(define (run expr)
  (begin
    (displayln (show expr))
    (if (reducible expr)
      (run (step expr))
      expr)))
