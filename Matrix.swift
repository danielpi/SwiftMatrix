//
//  Matrix.swift
//  SwiftMatrixExample
//
//  Created by Daniel Pink on 30/08/2014.
//  Copyright (c) 2014 Electronic Innovations. All rights reserved.
//

import Foundation
import Accelerate

// Lets just worry about 2 dimensional float matrices

public protocol SummableMultipliable: Equatable {
    func +(lhs: Self, rhs: Self) -> Self
    func *(lhs: Self, rhs: Self) -> Self
    func -(lhs: Self, rhs: Self) -> Self
    func /(lhs: Self, rhs: Self) -> Self
}

extension Int: SummableMultipliable {}
extension Float: SummableMultipliable {}
extension Double: SummableMultipliable {}

public struct Matrix: Equatable {
    var grid: [Double]
    public let rows: Int
    public let cols: Int
    public var size: (rows: Int, cols: Int) {
        get {
            return (rows, cols)
        }
    }
    public var T: Matrix {
        get {
            return self.transpose()
        }
    }
    
    public init(rows: Int, cols: Int, repeatedValue: Double) {
        self.rows = rows
        self.cols = cols
        grid = Array(count: rows * cols, repeatedValue: repeatedValue)
    }
    public init(rows: Int, cols: Int) {
        self.init(rows: rows, cols: cols, repeatedValue: 0.0)
    }
    public init(_ rows: Int,_ cols: Int) {
        self.init(rows: rows, cols: cols, repeatedValue: 0.0)
    }
    public init(_ data: [Double]) {
        grid = data
        rows = 1
        cols = data.count
    }
    public init(_ data: [[Double]]) {
        var matrix = Matrix(rows: data.count, cols: data[0].count)
        let no_columns = data[0].count
        for (i, row) in enumerate(data) {
            assert(no_columns == row.count, "Each row must be of the same length")
            for (j, value) in enumerate(row) {
                matrix[i, j] = value
            }
        }
        self = matrix
    }
    
    //public init(_ data: [[[Double]]]) { // Three dimensional array
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < cols
    }
    public subscript(row: Int) -> Double {
        get {
            // assert
            return grid[row]
        }
        set {
            grid[row] = newValue
        }
    }
    public subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * cols) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * cols) + column] = newValue
        }
    }
    
    public func transpose() -> Matrix {
        var newMatrix = Matrix(rows: cols, cols: rows)
        vDSP_mtransD(grid, 1, &newMatrix.grid, 1, vDSP_Length(cols), vDSP_Length(rows))
        return newMatrix
    }
}

// MARK: Literal
extension Matrix: ArrayLiteralConvertible {
    public static func convertFromArrayLiteral(elements: Double...) -> Matrix {
        let data = elements as [Double]
        var matrix = Matrix(data)
        return matrix
    }
/*    public static func convertFromArrayLiteral(elements: [Double]...) -> Matrix {
        let data = elements as [[Double]]
        var matrix = Matrix(data)
        return matrix
    }*/

}


// Equality for Doubles
extension Double {
    static var minNormal: Double { return 2.2250738585072014e-308 }
    static var min: Double { return 4.9406564584124654e-324 }
    static var max: Double { return 1.7976931348623157e308 }
}

public func nearlyEqual(a: Double, b: Double, epsilon: Double) -> Bool {
    let absA = abs(a)
    let absB = abs(b)
    let diff = abs(a - b)
    
    if (a == b) {
        return true
    } else if (a == 0 || b == 0 || diff < Double.minNormal) {
        return diff < (epsilon * Double.minNormal)
    } else {
        return (diff / (absA + absB)) < epsilon
    }
}

public func nearlyEqual(a: Double, b: Double) -> Bool {
    return nearlyEqual(a, b, 0.00000000000001)
}


// MARK: Factory methods
public func ones(rows: Int, cols: Int) -> Matrix {
    return Matrix(rows: rows, cols: cols, repeatedValue: 1.0)
}

public func zeros(rows: Int, cols: Int) -> Matrix {
    return Matrix(rows: rows, cols: cols, repeatedValue: 0.0)
}

public func eye(rows: Int) -> Matrix {
    var newMatrix = Matrix(rows: rows, cols: rows, repeatedValue: 0.0)
    for var index = 0; index < rows; ++index {
        newMatrix[index,index] = 1.0
    }
    return newMatrix
}

public func rand(rows: Int, cols: Int) -> Matrix {
    var x = Matrix(rows, cols)
    var distributionOption:__CLPK_integer = 1 // Uniform 0 to 1
    var seed = [__CLPK_integer(arc4random_uniform(4095)), __CLPK_integer(arc4random_uniform(4095)), __CLPK_integer(arc4random_uniform(4095)), __CLPK_integer((arc4random_uniform(2000) * 2) + 1)]
    var count:__CLPK_integer  = __CLPK_integer(rows * cols)
    dlarnv_(&distributionOption, &seed, &count, UnsafeMutablePointer<Double>(x.grid))
    return x
}

public func randn(rows: Int, cols: Int) -> Matrix {
    var x = zeros(rows, cols)
    var distributionOption:__CLPK_integer = 3 // Normal 0 to 1
    var seed = [__CLPK_integer(arc4random_uniform(4095)), __CLPK_integer(arc4random_uniform(4095)), __CLPK_integer(arc4random_uniform(4095)), __CLPK_integer((arc4random_uniform(2000) * 2) + 1)]
    var count:__CLPK_integer  = __CLPK_integer(rows * cols)
    dlarnv_(&distributionOption, &seed, &count, UnsafeMutablePointer<Double>(x.grid))
    return x
}

public func randn(rows: Int, cols: Int, #mean: Double, #sigma: Double) -> Matrix {
    return (randn(rows, cols) * sigma) + mean
}


// MARK: Operators
public func == (left: Matrix, right: Matrix) -> Bool {
    var result: Bool = true
    for (i, value) in enumerate(left.grid) {
        result = (result && nearlyEqual(value, right.grid[i]))
    }
    return result
}

public func + (left: Matrix, right: Matrix) -> Matrix {
    assert( (left.rows == right.rows) && (left.cols == right.cols) )
    var result = Matrix(rows: left.rows, cols: left.cols)
    vDSP_vaddD( left.grid, 1, right.grid, 1, &result.grid, 1, vDSP_Length(left.grid.count) )
    return result
}
public func + (left: Matrix, right: Double) -> Matrix {
    var result = Matrix(left.rows, left.cols)
    for (i, value) in enumerate(left.grid) {
        result[i] = value + right
    }
    return result
}
public func + (left: Double, right: Matrix) -> Matrix {
    var result = Matrix(right.rows, right.cols)
    for (i, value) in enumerate(right.grid) {
        result[i] = value + left
    }
    return result
}

public func - (left: Matrix, right: Matrix) -> Matrix {
    assert( (left.rows == right.rows) && (left.cols == right.cols) )
    var result = Matrix(rows: left.rows, cols: left.cols)
    vDSP_vsubD( right.grid, 1, left.grid, 1, &result.grid, 1, vDSP_Length(left.grid.count) )
    return result
}

public func * (left: Matrix, right:Double) -> Matrix {
    var result = Matrix(rows: left.rows, cols: left.cols)
    //vDSP_vsmulD( left.grid, 1, &right, &result.grid, 1, vDSP_Length(left.grid.count)) // Can't seem to get this to work
    for (i, value) in enumerate(left.grid) {
        result[i] = value * right
    }
    return result
}

public func * (left: Double, right:Matrix) -> Matrix {
    var result = Matrix(rows: right.rows, cols: right.cols)
    //vDSP_vsmulD( left.grid, 1, &right, &result.grid, 1, vDSP_Length(left.grid.count)) // Can't seem to get this to work
    for (i, value) in enumerate(right.grid) {
        result[i] = value * left
    }
    return result
}

// What to use for a transpose operator?
// Matlab and Julia use ' (But swift won't let me use that)
// Numpy uses .T (Two characters for such a common task)
// Not allowed but would be cool: ᵀ
// Allowed but not standared: † ′ ‵ ⊺ τ
postfix operator ⊺ {}
public postfix func ⊺ (matrix: Matrix) -> Matrix {
    return matrix.transpose()
}















