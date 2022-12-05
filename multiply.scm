#lang racket

(require "show.scm")

(provide Multiply)

(struct Multiply (left right)
	#:methods gen:show-elem
	[(define (show val) (show-mul val))])

(define (show-mul val) (format "~a * ~a" (show (Multiply-left val)) (show (Multiply-right val))))

