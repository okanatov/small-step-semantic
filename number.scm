#lang racket

(provide Number Number? Number-value make-number)

(struct Number (value))

(define (make-number v)
  (cons 'number v))
