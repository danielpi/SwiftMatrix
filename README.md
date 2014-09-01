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
	

Issues, Improvements, Random Thoughts
- How do I go about making the matrix multi dimensional?
- Array literals are cool but they must be explicitly declared at present so that the compiler doesn't infer an array instead (defeating the point to some degree)
- Would be good to use ; as a new row marker, I'm not sure if that is possible.
- Would like to be able to have a matrix of Ints or Floats (or any other data type for that matter). Need to be able to specify that only numeric values (though also imaginary numbers) are allowed. Also what happens when a calculation is performed on mixed types?
- How to slice an entire row or column? Matlab uses a(:,2) to get the second column of data. 