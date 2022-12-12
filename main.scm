#lang racket

(require
  "machine.scm"
  "add.scm"
  "multiply.scm"
  "number.scm"
  "boolean.scm"
  "lessthan.scm"
  "variable.scm"
  "assign.scm"

"showable.scm" "reducible.scm"

  )

(define env0 (hash))
(define env (hash-set
	      (hash-set env0 "x" 3)
	      "y" 4))

;(machine-step (LessThan
;               (Number 5)
;               (Add (Multiply (Number 1) (Number 2))
;                    (Multiply (Number 3) (Variable "y"))))
;              env)

(define s (Assign "x" (Add (Variable "x") (Number 1))))
(displayln (show s))
(can-be-reduced s)

(define s1 (reduce s env))
(displayln(show (car s1)))
(can-be-reduced (car s1))

(define s2 (reduce (car s1) env))
(displayln (show (car s2)))
(can-be-reduced (car s2))

(define s3 (reduce (car s2) env))
(displayln (show (car s3)))
(can-be-reduced (car s3))


