#lang racket

(require
  "machine.scm"
  "add.scm"
  "multiply.scm"
  "number.scm"
  "boolean.scm"
  "lessthan.scm"
  "variable.scm"
  )

(define env0 (hash))
(define env (hash-set
	      (hash-set env0 "x" 3)
	      "y" 4))

(machine-step (LessThan
               (Number 5)
               (Add (Multiply (Number 1) (Number 2))
                    (Multiply (Number 3) (Variable "y"))))
              env)

