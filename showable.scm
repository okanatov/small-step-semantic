#lang racket

(require racket/generic)

(provide gen:showable show)

(define-generics showable 
  [show showable])

