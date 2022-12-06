#lang racket

(require "showable.scm" "reducible.scm" "number.scm")

(provide Multiply)

(struct Multiply (left right)
	#:methods gen:showable
	[(define (show val) (show-mul val))]

	#:methods gen:reducible
	[(define (can-be-reduced val) (reducible-mul? val))
	 (define (reduce val) (reduce-mul val))])

(define (show-mul val) (format "~a * ~a" (show (Multiply-left val)) (show (Multiply-right val))))

(define (reducible-mul? val) #true)

(define (reduce-mul val)
  (cond
    [(can-be-reduced (Multiply-left val)) (Multiply (reduce (Multiply-left val)) (Multiply-right val))]
    [(can-be-reduced (Multiply-right val)) (Multiply (Multiply-left val) (reduce (Multiply-right val)))]
    [else (Number (* (Number-value (Multiply-left val)) (Number-value (Multiply-right val))))]))

