#lang racket

(require "showable.scm" "reducible.scm" "number.scm")

(provide Add)

(struct Add (left right)
	#:methods gen:showable
	[(define (show val) (show-add val))]

	#:methods gen:reducible
	[(define (can-be-reduced val) (reducible-add? val))
	 (define (reduce val) (reduce-add val))])

(define/contract (show-add val)
		 (Add? . -> . string?)
		 (format "~a + ~a" (show (Add-left val)) (show (Add-right val))))

(define/contract (reducible-add? val)
		 (Add? . -> . boolean?)
		 #true)

(define/contract (reduce-add val)
		 (Add? . -> . (or/c Number? Add?))
		 (cond
		   [(can-be-reduced (Add-left val))
		    (Add (reduce (Add-left val)) (Add-right val))]
		   [(can-be-reduced (Add-right val))
		    (Add (Add-left val) (reduce (Add-right val)))]
		   [else
		     (Number (+ (Number-value (Add-left val)) (Number-value (Add-right val))))]))

