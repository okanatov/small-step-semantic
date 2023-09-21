#lang racket

(require "operations.scm" "tags.scm" "machine.scm" "number.scm" "add.scm" "variable.scm")

(define a (make-number (Number 4)))
(define b (make-number (Number 6)))

(define c (make-add (Add a b)))
;(run c (hash))
;(Number-value (get-content m))


(define v1 (make-variable (Variable "x")))
(define v2 (make-variable (Variable "y")))
;(run v1 (hash "x" 1 "y" 2))

(define d (make-add (Add v1 v2)))
(run d (hash "x" 1 "y" 2))
