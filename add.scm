#lang racket

(require "show.scm")

(provide Add)

(struct Add (left right)
	#:methods gen:show-elem
	[(define (show val) (show-add val))])

(define (show-add val) (format "~a + ~a" (show (Add-left val)) (show (Add-right val))))

