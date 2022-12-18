#lang racket

(require "showable.scm" "reducible.scm" "if.scm" "sequence.scm" "donothing.scm")

(provide While)

(struct While (condition body)
        #:methods gen:showable
        [(define (show val) (show-while val))]

        #:methods gen:reducible
        [(define (can-be-reduced val) (reducible-while? val))
         (define (reduce val env) (reduce-while val env))])

(define/contract (show-while val)
                 (While? . -> . string?)
                 (format "while (~a) { ~a }" (show (While-condition val)) (show (While-body val))))

(define/contract (reducible-while? val)
                 (While? . -> . boolean?)
                 #true)

(define/contract (reduce-while val env)
		 (While? hash? . -> . cons?)
		 (cons (If (While-condition val)
			   (Sequence (While-body val) val)
			   (DoNothing))
		       env))

