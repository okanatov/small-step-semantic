#lang racket

(require "showable.scm" "reducible.scm" "boolean.scm" "number.scm")

(provide LessThan)

(struct LessThan (left right)
	#:methods gen:showable
	[(define (show val) (show-less-than val))]

	#:methods gen:reducible
	[(define (can-be-reduced val) (reducible-less-than? val))
	 (define (reduce val) (reduce-less-than val))])

(define/contract (show-less-than val)
		 (LessThan? . -> . string?)
		 (format "~a < ~a" (show (LessThan-left val)) (show (LessThan-right val))))

(define/contract (reducible-less-than? val)
		 (LessThan? . -> . boolean?)
		 #true)

(define/contract (reduce-less-than val)
		 (LessThan? . -> . (or/c Boolean? LessThan?))
		 (cond
		   [(can-be-reduced (LessThan-left val))
		    (LessThan (reduce (LessThan-left val)) (LessThan-right val))]
		   [(can-be-reduced (LessThan-right val))
		    (LessThan (LessThan-left val) (reduce (LessThan-right val)))]
		   [else
		     (Boolean (< (Number-value (LessThan-left val)) (Number-value (LessThan-right val))))]))

