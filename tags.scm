#lang racket

(provide get-type get-content)

(define (get-type v)
  (if (pair? v)
    (car v)
    (error "get-type: Not implemented")))

(define (get-content v)
  (if (pair? v)
    (cdr v)
    (error "get-content: Not implemented")))

