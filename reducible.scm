#lang racket

(require racket/generic)

(provide gen:reducible can-be-reduced reduce)

(define-generics reducible 
		 [can-be-reduced reducible]
		 [reduce reducible])

