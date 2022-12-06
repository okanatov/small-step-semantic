#lang racket

(require "showable.scm" "reducible.scm")

(provide Boolean Boolean-value)

(struct Boolean (value)
	#:methods gen:showable
	[(define (show val) (show-boolean val))]

	#:methods gen:reducible
	[(define (can-be-reduced val) (reducible-boolean? val))])

(define (show-boolean val) (format "~a" (Boolean-value val)))
(define (reducible-boolean? val) #false)

