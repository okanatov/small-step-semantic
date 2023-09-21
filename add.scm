#lang racket

(provide Add Add? Add-left Add-right make-add)

(struct Add (left right))

(define (make-add v)
  (cons 'add v))
