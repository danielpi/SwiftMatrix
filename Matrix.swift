//
//  Matrix.swift
//  SwiftMatrixExample
//
//  Created by Daniel Pink on 30/08/2014.
//  Copyright (c) 2014 Electronic Innovations. All rights reserved.
//

import Foundation

public struct Matrix: Equatable {
    let rows: Int, columns: Int
    var grid: [Double]
    public init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    public init(_ data: [Double]) {
        var matrix = Matrix(rows: 1, columns: data.count)
        for (i, value) in enumerate(data) {
            matrix[i] = value
        }
        self = matrix
    }
    public init(_ data: [[Double]]) {
        var matrix = Matrix(rows: data.count, columns: data[0].count)
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
        var matrix = Matrix(data)
        return matrix
    }
/*    public static func convertFromArrayLiteral(elements: [Double]...) -> Matrix {
        let data = elements as [[Double]]
        var matrix = Matrix(data)
        return matrix
    }*/

}



// MARK: Operators

public func == (left: Matrix, right: Matrix) -> Bool {
    if (left.grid == right.grid) {
        return true
    } else {
        return false
    }
}

//func + (left: Matrix, right: Matrix) -> Matrix {
    
    //return
//}