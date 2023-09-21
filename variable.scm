#lang racket

(provide Variable Variable? Variable-name make-variable)

(struct Variable (name))

(define (make-variable v)
  (cons 'variable v))
