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
  "if.scm"
  "sequence.scm"
  "while.scm"
  )


(define f (machine-step (While (LessThan (Variable "x") (Number 5))
			       (Assign "x" (Multiply (Variable "x") (Number 3))))
			(hash-set (hash) "x" 1)))

(displayln f)

