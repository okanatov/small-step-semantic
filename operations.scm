#lang racket

(require "tags.scm" "number.scm" "boolean.scm" "add.scm" "multiply.scm" "variable.scm")

(provide reduce reducible show)

(define ophash (hash 'reducible (hash 'number #f 'boolean #f 'add #t 'multiply #t 'variable #t)

                     'show (hash 'number (lambda (v) (format "~a" (Number-value v)))
                                 'boolean (lambda (v) (format "~a" (Boolean-value v)))
                                 'add (lambda (v) (format "~a + ~a" (show (Add-left v)) (show (Add-right v))))
                                 'multiply (lambda (v) (format "~a * ~a" (show (Multiply-left v)) (show (Multiply-right v))))
                                 'variable (lambda (v) (format "~a" (Variable-name v))))


                     'reduce    (hash 'number (lambda (v e) (error "reduce(number: Not implemented"))
                                      'boolean (lambda (v e) (error "reduce(boolean): Not implemented"))

                                      'add (lambda (v e) (let* ([left-part (Add-left v)]
                                                              [right-part (Add-right v)]
                                                              [left-part-content (get-content left-part)]
                                                              [right-part-content (get-content right-part)])

                                                         (cond [(reducible left-part)
                                                                (make-add (Add (reduce left-part e) right-part))]
                                                               [(reducible right-part)
                                                                (make-add (Add left-part (reduce right-part e)))]
                                                               [else (make-number (Number (+ (Number-value left-part-content)
                                                                                             (Number-value right-part-content))))])))

                                      'multiply (lambda (v e) (let* ([left-part (Multiply-left v)]
                                                                   [right-part (Multiply-right v)]
                                                                   [left-part-content (get-content left-part)]
                                                                   [right-part-content (get-content right-part)])

                                                              (cond [(reducible left-part)
                                                                     (make-multiply (Multiply (reduce left-part e) right-part))]
                                                                    [(reducible right-part)
                                                                     (make-multiply (Multiply left-part (reduce right-part e)))]
                                                                    [else (make-number (Number (* (Number-value left-part-content)
                                                                                                  (Number-value right-part-content))))])))

                                      'variable (lambda (v e) (make-number (Number (hash-ref e (Variable-name v))))))))

(define/contract (reducible val)
                 ((cons/c symbol? (or/c Number? Boolean? Add? Multiply? Variable?)) . -> . boolean?)
                 (hash-ref (hash-ref ophash 'reducible) (get-type val)))

(define/contract (reduce val env)
                 ((cons/c symbol? (or/c Number? Boolean? Add? Multiply? Variable?)) hash? . -> .
                  (cons/c symbol? (or/c Number? Boolean? Add? Multiply? Variable?)))
                 ((hash-ref (hash-ref ophash 'reduce) (get-type val)) (get-content val) env))

(define/contract (show val)
                 ((cons/c symbol? (or/c Number? Boolean? Add? Multiply? Variable?)) . -> . string?)
                 ((hash-ref (hash-ref ophash 'show) (get-type val)) (get-content val)))
