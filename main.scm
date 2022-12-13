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
  )

(define env (hash-set
	      (hash-set (hash) "x" 3)
	      "y" 4))

(define f (machine-step (Assign "x" (LessThan
				      (Number 5)
				      (Add (Multiply (Variable "x") (Number 2))
					   (Multiply (Number 3) (Variable "y")))))
			env))

(displayln f)
