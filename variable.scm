#lang racket

(require "showable.scm" "reducible.scm" "number.scm")

(provide Variable)

(struct Variable (name)
  #:methods gen:showable
  [(define (show name) (show-var name))]

  #:methods gen:reducible
  [(define (can-be-reduced val) (reducible-var? val))
   (define (reduce val env) (reduce-var val env))])

(define/contract (show-var val)
  (Variable? . -> . string?)
  (format "~a" (Variable-name val)))

(define/contract (reducible-var? val)
  (Variable? . -> . boolean?)
  #true)

(define/contract (reduce-var val env)
  (Variable? hash? . -> . Number?)
  (Number (hash-ref env (Variable-name val))))
