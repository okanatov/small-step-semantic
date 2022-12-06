#lang racket

(require "machine.scm" "add.scm" "multiply.scm" "number.scm" "boolean.scm" "lessthan.scm")

(machine-step (LessThan
		(Number 5)
		(Add (Multiply (Number 1) (Number 2))
		     (Multiply (Number 3) (Number 4)))))

