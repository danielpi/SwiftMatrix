SwiftMatrix
===========

Some experiments implementing a Matrix data type in Swift

	let a: Matrix = [1,2,3,4]
	let b = Matrix([1,2,3,4])
	// let a = [1,2,3,4] // Would be better but gets inferred as an Array
	
	if (a == b) {
		println("They are equal")
	}
	
	let c = a + b
	let d = a - b
	let e = a * c
	let f = e / b
	let g = a .* b
	a'
	a.shape // (rows:1, columns:4)
	

## Issues, Improvements, Random Thoughts
- How do I go about making the matrix multi dimensional?
- Array literals are cool but they must be explicitly declared at present so that the compiler doesn't infer an array instead (defeating the point to some degree)
- Would be good to use ; as a new row marker, I'm not sure if that is possible.
- Would like to be able to have a matrix of Ints or Floats (or any other data type for that matter). Need to be able to specify that only numeric values (though also imaginary numbers) are allowed. Also what happens when a calculation is performed on mixed types?
- How to slice an entire row or column? Matlab uses a(:,2) to get the second column of data. 
- I've had a pretty good go at implementing a matrix class with generics. It hasn't worked out very well though. I think it is more important for the library to specialise on each of the most common data types. The underlying Accelerate library does this so I don't think I can take advantage of it without also being specific. It would be good if this library could use operator overloading though so that you can not have to worry about your data types (as much as possible).
- How to handle equality of floating point numbers in Swift.

## Stages
- Write it for Humans to be able to read
- Build a performance test suite
- Optimise
- Benchmark

## Design Decisions
### Matrix Creation
Matlab            | Julia              | Numpy                        | R         
----------------- | ------------------ | ---------------------------- | ------------- 
A = [1,2,3;4,5,6] | A = [1 2 3; 4 5 6] | a = array([[1,2,3],[4,5,6]]) | A = matrix(0.0,nrow=2,ncol=3) 
A = [1 2 3; 5 6 7]|

SwiftMatrix:
	
	let A = Matrix([[1,2,3],[4,5,6]])
	let A: Matrix = [[1,2,3],[4,5,6]]
	
Matlab and Julia only require 17 keystrokes for input their matrices. SwiftMatrix requires 33 characters. I could drop down to 26 by removing the type specifier from the second option however input will be inferred as an array of arrays of Ints. I also don't have any means of specifying the type of the elements of the Matrix at present.

### Display

Matlab

	>> A = [1 2 3; 5 6 7]

	A =

 	    1     2     3
 	    5     6     7

Julia

	julia> A = [1 2 3; 5 6 7]
	2x3 Array{Int64,2}:
	 1  2  3
	 5  6  7

Numpy

	a = array([[1,2,3],[4,5,6]])
	array([[1, 2, 3],
           [4, 5, 6]])
R
	
	> A = matrix(0.0,nrow=2,ncol=3)
	> A
	     [,1] [,2] [,3]
	[1,]    0    0    0
	[2,]    0    0    0

Swift Matrix:

Not sure yet. Matlab does the best job of putting the data out by itself so that it is easy to view (Good use of whitespace). Julia is a bit more compact and also specifies the type (No punctuation used). Numpy out put is very visually dense. I think all the ([[,]]) characters get in the way. Numpy gets points for being able to copy the output and paste it back in as input. R is a bit of a mess. The row and column names highlight its main focus (data.frames). I do like R's use of space and layout though.

Swift will need to output to a couple of different places
- Debug console
- REPL
- Playground console
- Playground results gutter (Single line and expanded view)

Possible SwiftMatrix outputs

	let A: Matrix = [[1,2,3],[4,5,6]]
	A 	2x3 Double
		1	2	3
		4	5	6
		


### Transpose

Matlab      | Julia         | Numpy         | R         
----------- | ------------- | ------------- | ------------- 
A'     		| A'			| A.T			| T(A)
transpose(A)|   			| A.transpose() | 

SwiftMatrix:
Much as I would like to I can't use A' as it is not allowed as an operator character. Taking the transpose of a matrix is a very common activity so I would prefer if it was a single character operator. From the Swift documentation here are the available options

> Custom operators can begin with one of the ASCII characters /, =, -, +, !, *, %, <, >, &, |, ^, or ~, or one of the Unicode characters defined in the grammar below. After the first character, combining Unicode characters are also allowed. You can also define custom operators as a sequence of two or more dots (for example, ....).

	None of the allowed characters really work
	A^ 
	A| 
	A~
	A!
	
	This would be awesome but it is not allowed
	Aᵀ	
	
	Allowed but not great
	A†	
	A′ 
	A‵ 
	
	A.t
	A.T
	
I think I prefer A.T

### Matrix Multiplication

Matlab      | Julia         | Numpy               | R         
----------- | ------------- | ------------------- | ------------- 
A * B    	| A * B		    | matrixmultiply(A,B) | A %*% B
            |  		    	| inner(A,B)          | 
            |   			| outer(A,B)          | 





