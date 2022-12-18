#lang racket

(require "showable.scm" "reducible.scm")

(provide Sequence)

(struct Sequence (first second)
        #:methods gen:showable
        [(define (show val) (show-sequence val))]

        #:methods gen:reducible
        [(define (can-be-reduced val) (reducible-sequence? val))
         (define (reduce val env) (reduce-sequence val env))])

(define/contract (show-sequence val)
                 (Sequence? . -> . string?)
                 (format "{ ~a; ~a }" (show (Sequence-first val)) (show (Sequence-second val))))

(define/contract (reducible-sequence? val)
                 (Sequence? . -> . boolean?)
                 #true)

(define/contract (reduce-sequence val env)
		 (Sequence? hash? . -> . cons?)
		 (cond
		   [(can-be-reduced (Sequence-first val))
		    (let
		      ([frame (reduce (Sequence-first val) env)])
		      (cons (Sequence (car frame) (Sequence-second val)) (cdr frame)))]
		    [else
		      (cons (Sequence-second val) env)]))

