#lang racket

(require "showable.scm" "reducible.scm")

(provide Multiply)

(struct Multiply (left right)
	#:methods gen:showable
	[(define (show val) (show-mul val))]

	#:methods gen:reducible
	[(define (can-be-reduced val) (reducible-mul? val))])

(define (show-mul val) (format "~a * ~a" (show (Multiply-left val)) (show (Multiply-right val))))
(define (reducible-mul? val) #true)

