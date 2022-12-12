#lang racket

(require racket/contract)
(require "showable.scm" "reducible.scm")

(provide DoNothing DoNothing?)

(struct DoNothing ()
  #:methods gen:showable
  [(define (show val) (show-donothing val))]

  #:methods gen:reducible
  [(define (can-be-reduced val) (reducible-donothing? val))])

(define/contract (show-donothing val)
  (DoNothing? . -> . string?)
  (format "Do-Nothing"))

(define/contract (reducible-donothing? val)
  (DoNothing? . -> . boolean?)
  #false)

