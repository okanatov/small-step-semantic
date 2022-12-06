#lang racket

(require "showable.scm" "reducible.scm")

(provide Add)

(struct Add (left right)
	#:methods gen:showable
	[(define (show val) (show-add val))]

	#:methods gen:reducible
	[(define (can-be-reduced val) (reducible-add? val))])

(define (show-add val) (format "~a + ~a" (show (Add-left val)) (show (Add-right val))))
(define (reducible-add? val) #true)

