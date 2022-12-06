#lang racket

(require racket/contract)
(require "showable.scm" "reducible.scm")

(provide Number Number-value Number?)

(struct Number (value)
	#:methods gen:showable
	[(define (show val) (show-num val))]

	#:methods gen:reducible
	[(define (can-be-reduced val) (reducible-num? val))])

(define/contract (show-num val)
		 (Number? . -> . string?)
		 (format "~a" (Number-value val)))

(define/contract (reducible-num? val)
		 (Number? . -> . boolean?)
		 #false)

