#lang racket

(provide Boolean Boolean? Boolean-value make-boolean)

(struct Boolean (value))

(define (make-boolean v)
  (cons 'boolean v))
