#lang racket

(require "show.scm")

(provide Number)

(struct Number (value)
	#:methods gen:show-elem
	[(define (show val) (show-num val))])

(define (show-num val) (format "~a" (Number-value val)))

