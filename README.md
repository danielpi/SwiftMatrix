SwiftMatrix
===========

Some experiments implementing a Matrix data type in Swift

	let aMatrix: Matrix = [1,2,3,4]
	let bMatrix = Matrix([1,2,3,4])
	// let aMatrix = [1,2,3,4] // Would be better but gets inferred as an Array
	
	if (aMatrix == bMatrix) {
		println("They are equal")
	}

Issues, Improvements, Random Thoughts
- How do I go about making the matrix multi dimensional?
- Array literals are cool but they must be explicitly declared at present so that the compiler doesn't infer an array instead (defeating the point to some degree)
- Would be good to use ; as a new row marker, I'm not sure if that is possible.
- Would like to be able to have a matrix of Ints or Floats (or any other data type for that matter). Need to be able to specify that only numeric values (though also imaginary numbers) are allowed. Also what happens when a calculation is performed on mixed types?
