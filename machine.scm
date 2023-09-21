#lang racket

(require "operations.scm" "tags.scm")

(provide run)

(define (step expr env)
  (reduce expr env))

(define (run expr env)
  (begin
    (display (show expr))
    (display " : ")
    (displayln env)
    (if (reducible expr)
      (run (step expr env) env)
      expr)))
