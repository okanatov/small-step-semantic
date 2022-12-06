#lang racket

(require "showable.scm" "reducible.scm")

(provide Boolean Boolean-value Boolean?)

(struct Boolean (value)
	#:methods gen:showable
	[(define (show val) (show-boolean val))]

	#:methods gen:reducible
	[(define (can-be-reduced val) (reducible-boolean? val))])

(define/contract (show-boolean val)
		 (Boolean? . -> . string?)
		 (format "~a" (Boolean-value val)))

(define/contract (reducible-boolean? val)
		 (Boolean? . -> . boolean?)
		 #false)

