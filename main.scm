#lang racket

(require "show.scm" "add.scm" "multiply.scm" "number.scm")

(display (show (Add
		 (Multiply (Number 1) (Number 2))
		 (Multiply (Number 3) (Number 4)))))
