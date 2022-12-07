#lang racket

(require "showable.scm" "reducible.scm" "number.scm")

(provide Multiply)

(struct Multiply (left right)
  #:methods gen:showable
  [(define (show val) (show-mul val))]

  #:methods gen:reducible
  [(define (can-be-reduced val) (reducible-mul? val))
   (define (reduce val env) (reduce-mul val env))])

(define/contract (show-mul val)
  (Multiply? . -> . string?)
  (format "~a * ~a" (show (Multiply-left val)) (show (Multiply-right val))))

(define/contract (reducible-mul? val)
  (Multiply? . -> . boolean?)
  #true)

(define/contract (reduce-mul val env)
  (Multiply? hash? . -> . (or/c Number? Multiply?))
  (cond
    [(can-be-reduced (Multiply-left val))
     (Multiply (reduce (Multiply-left val) env) (Multiply-right val))]
    [(can-be-reduced (Multiply-right val))
     (Multiply (Multiply-left val) (reduce (Multiply-right val) env))]
    [else
     (Number (* (Number-value (Multiply-left val)) (Number-value (Multiply-right val))))]))

