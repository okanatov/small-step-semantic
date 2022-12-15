#lang racket

(require "showable.scm" "reducible.scm" "number.scm" "boolean.scm")

(provide If)

(struct If (condition consequence alternative)
        #:methods gen:showable
        [(define (show val) (show-if val))]

        #:methods gen:reducible
        [(define (can-be-reduced val) (reducible-if? val))
         (define (reduce val env) (reduce-if val env))])

(define/contract (show-if val)
                 (If? . -> . string?)
                 (format "if (~a) { ~a } else { ~a } " (show (If-condition val))
                         (show (If-consequence val))
                         (show (If-alternative val))))

(define/contract (reducible-if? val)
                 (If? . -> . boolean?)
                 #true)

(define/contract (reduce-if val env)
                 (If? hash? . -> . cons?)
                 (cond
                   [(can-be-reduced (If-condition val))
                    (cons (If (reduce (If-condition val) env)
                              (If-consequence val)
                              (If-alternative val)) env)]
                   [else
                     (if (Boolean-value (If-condition val))
                       (cons (If-consequence val) env)
                       (cons (If-alternative val) env))]))

