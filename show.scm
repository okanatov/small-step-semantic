#lang racket

(require racket/generic)

(provide gen:show-elem show)

(define-generics show-elem
		 [show show-elem])

