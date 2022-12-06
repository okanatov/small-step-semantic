#lang racket

(require "showable.scm" "reducible.scm" "boolean.scm" "number.scm")

(provide LessThan)

(struct LessThan (left right)
	#:methods gen:showable
	[(define (show val) (show-less-than val))]

	#:methods gen:reducible
	[(define (can-be-reduced val) (reducible-less-than? val))
	 (define (reduce val) (reduce-less-than val))])

(define (show-less-than val) (format "~a < ~a" (show (LessThan-left val)) (show (LessThan-right val))))

(define (reducible-less-than? val) #true)

(define (reduce-less-than val)
  (cond
    [(can-be-reduced (LessThan-left val)) (LessThan (reduce (LessThan-left val)) (LessThan-right val))]
    [(can-be-reduced (LessThan-right val)) (LessThan (LessThan-left val) (reduce (LessThan-right val)))]
    [else (Boolean (< (Number-value (LessThan-left val)) (Number-value (LessThan-right val))))]))

