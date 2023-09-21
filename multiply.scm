#lang racket

(provide Multiply Multiply? Multiply-left Multiply-right make-multiply)

(struct Multiply (left right))

(define (make-multiply v)
  (cons 'multiply v))
