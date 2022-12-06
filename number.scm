#lang racket

(require "showable.scm" "reducible.scm")

(provide Number Number-value)

(struct Number (value)
	#:methods gen:showable
	[(define (show val) (show-num val))]

	#:methods gen:reducible
	[(define (can-be-reduced val) (reducible-num? val))])

(define (show-num val) (format "~a" (Number-value val)))
(define (reducible-num? val) #false)

