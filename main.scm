#lang racket

(require "operations.scm" "tags.scm" "machine.scm" "number.scm" "add.scm")

(define a (cons 'number (Number 4)))
(define b (cons 'number (Number 6)))

(define c (cons 'add  (Add a b)))
(run c)
;(Number-value (get-content m))
