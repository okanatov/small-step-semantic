#lang racket

(require "tags.scm" "number.scm" "boolean.scm" "add.scm" "multiply.scm")

(provide reduce reducible show)

(define ophash (hash 'reducible (hash 'number #f 'boolean #f 'add #t 'multiply #t)

                     'show (hash 'number (lambda (v) (format "~a" (Number-value v)))
                                 'boolean (lambda (v) (format "~a" (Boolean-value v)))
                                 'add (lambda (v) (format "~a + ~a" (show (Add-left v)) (show (Add-right v))))
                                 'multiply (lambda (v) (format "~a * ~a" (show (Multiply-left v)) (show (Multiply-right v)))))


                     'reduce    (hash 'number (lambda (v) (error "reduce(number: Not implemented"))
                                      'boolean (lambda (v) (error "reduce(boolean): Not implemented"))

                                      'add (lambda (v) (let* ([left-part (Add-left v)]
                                                              [right-part (Add-right v)]
                                                              [left-part-content (get-content left-part)]
                                                              [right-part-content (get-content right-part)])

                                                         (cond [(reducible left-part)
                                                                (make-add (Add (reduce left-part) right-part))]
                                                               [(reducible right-part)
                                                                (make-add (Add left-part (reduce right-part)))]
                                                               [else (make-number (Number (+ (Number-value left-part-content)
                                                                                             (Number-value right-part-content))))])))

                                      'multiply (lambda (v) (let* ([left-part (Multiply-left v)]
                                                                   [right-part (Multiply-right v)]
                                                                   [left-part-content (get-content left-part)]
                                                                   [right-part-content (get-content right-part)])

                                                              (cond [(reducible left-part)
                                                                     (make-multiply (Multiply (reduce left-part) right-part))]
                                                                    [(reducible right-part)
                                                                     (make-multiply (Multiply left-part (reduce right-part)))]
                                                                    [else (make-number (Number (* (Number-value left-part-content)
                                                                                                  (Number-value right-part-content))))]))))))

(define/contract (reducible val)
                 ((cons/c symbol? (or/c Number? Boolean? Add? Multiply?)) . -> . boolean?)
                 (hash-ref (hash-ref ophash 'reducible) (get-type val)))

(define/contract (reduce val)
                 ((cons/c symbol? (or/c Number? Boolean? Add? Multiply?)) . -> .
                                                                          (cons/c symbol? (or/c Number? Boolean? Add? Multiply?)))
                 ((hash-ref (hash-ref ophash 'reduce) (get-type val)) (get-content val)))

(define/contract (show val)
                 ((cons/c symbol? (or/c Number? Boolean? Add? Multiply?)) . -> . string?)
                 ((hash-ref (hash-ref ophash 'show) (get-type val)) (get-content val)))
