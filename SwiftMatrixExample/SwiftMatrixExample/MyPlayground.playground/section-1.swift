// Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"


struct Mat<T: IntegerLiteralConvertible> {
    var grid = [T]()
}

let a = Mat(grid: [1,2,3])
let b = Mat(grid: [4.5,1.2])

