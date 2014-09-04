//
//  Matrix.swift
//  SwiftMatrixExample
//
//  Created by Daniel Pink on 30/08/2014.
//  Copyright (c) 2014 Electronic Innovations. All rights reserved.
//

import Foundation

// Approach one to allowing for a generic matrix implementation involves creating a protocol that lists all the operations that we want our element type to be able to handle.
public protocol SummableMultipliable: Equatable {
    func +(lhs: Self, rhs: Self) -> Self
    func *(lhs: Self, rhs: Self) -> Self
    func -(lhs: Self, rhs: Self) -> Self
}

extension Int: SummableMultipliable {}
extension Double: SummableMultipliable {}


// Approach two involves manually grouping the types that we know we want to be able to use into a numeric type
public protocol Numeric {}
extension Int: Numeric {}
extension Double: Numeric {}
extension Float: Numeric {}


public struct Matrix<T: SummableMultipliable> {
    var grid: [T]
    let rows: Int
    let columns: Int
    public var shape: (r: Int, c: Int) {
        get {
            return (rows, columns)
        }
    }
    
    public init(rows: Int, columns: Int, initialValue: T) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: initialValue)
    }
    public init(_ data: [T]) {
        grid = data
        rows = 1
        columns = data.count
    }
    public init(_ data: [[T]]) {
        var matrix = Matrix(rows: data.count, columns: data[0].count, initialValue: data[0][0])
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
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    public subscript(row: Int) -> T {
        get {
            // assert
            return grid[row]
        }
        set {
            grid[row] = newValue
        }
    }
    public subscript(row: Int, column: Int) -> T {
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
    
}

// MARK: Literal
extension Matrix: ArrayLiteralConvertible {
    public static func convertFromArrayLiteral(elements: Double...) -> Matrix {
        let data = elements as [Double]
        var matrix = Matrix<Double>(data)
        return matrix
    }
/*    public static func convertFromArrayLiteral(elements: [Double]...) -> Matrix {
        let data = elements as [[Double]]
        var matrix = Matrix(data)
        return matrix
    }*/

}


// MARK: Operators

public func == (left: Matrix<Int>, right: Matrix<Int>) -> Bool {
    if (left.grid == right.grid) {
        return true
    } else {
        return false
    }
}

public func + (left: Matrix, right: Matrix) -> Matrix {
    // Should check that left and right have the same shape
    //assert(left.shape == right.shape, "Matrices need to be the same shape to be added together")
    var temp = Matrix(rows: left.rows, columns: left.columns)
    for (i, value) in enumerate(left.grid) {
        temp[i] = value + right[i]
    }
    return temp
}

public func - (left: Matrix, right: Matrix) -> Matrix {
    // Should check that left and right have the same shape
    //assert(left.shape == right.shape, "Matrices need to be the same shape to be added together")
    var temp = Matrix(rows: left.rows, columns: left.columns)
    for (i, value) in enumerate(left.grid) {
        temp[i] = value - right[i]
    }
    return temp
}



