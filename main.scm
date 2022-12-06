#lang racket

(require "showable.scm" "reducible.scm" "add.scm" "multiply.scm" "number.scm")

(show (Add
	(Multiply (Number 1) (Number 2))
	(Multiply (Number 3) (Number 4))))

(can-be-reduced (Number 1))
(can-be-reduced (Add (Number 1) (Number 2)))
(can-be-reduced (Multiply (Number 1) (Number 2)))
