#lang racket

(require "showable.scm" "reducible.scm" "donothing.scm" "number.scm")

(provide Assign)

(struct Assign (name expr)
  #:methods gen:showable
  [(define (show val) (show-assign val))]

  #:methods gen:reducible
  [(define (can-be-reduced val) (reducible-assign? val))
   (define (reduce val env) (reduce-assign val env))])

(define/contract (show-assign val)
  (Assign? . -> . string?)
  (format "~a = ~a" (Assign-name val) (show (Assign-expr val))))

(define/contract (reducible-assign? val)
  (Assign? . -> . boolean?)
  #true)

(define/contract (reduce-assign val env)
  (Assign? hash? . -> . cons?)
  (cond
    [(can-be-reduced (Assign-expr val))
     (cons (Assign (Assign-name val) (reduce (Assign-expr val) env)) env)]
    [else
     (cons (DoNothing) (hash-set env (Assign-name val) (Number-value (Assign-expr val))))]))

