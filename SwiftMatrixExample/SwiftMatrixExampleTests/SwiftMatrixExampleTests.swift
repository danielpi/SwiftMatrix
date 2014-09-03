//
//  SwiftMatrixExampleTests.swift
//  SwiftMatrixExampleTests
//
//  Created by Daniel Pink on 30/08/2014.
//  Copyright (c) 2014 Electronic Innovations. All rights reserved.
//

import Cocoa
import XCTest
import SwiftMatrixExample


class SwiftMatrixExampleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEmptyMatrix() {
        // This is an example of a functional test case.
        let matrix = Matrix(rows: 2, columns: 2)
        XCTAssertEqualWithAccuracy(matrix[0,0], 0.0, 0.001, "All Values should be 0.0")
        XCTAssertEqualWithAccuracy(matrix[1,0], 0.0, 0.001, "All Values should be 0.0")
        XCTAssertEqualWithAccuracy(matrix[0,1], 0.0, 0.001, "All Values should be 0.0")
        XCTAssertEqualWithAccuracy(matrix[1,1], 0.0, 0.001, "All Values should be 0.0")
    }
    
    func testMatrixCreation1() {
        let matrix1 = Matrix([1,2,3])
        let matrix2: Matrix = [1,2,3]   // Would like to be able to get ride of the explicit type declaration
                                        // but the type inference mechanisms think this is an array
        XCTAssertEqual(matrix1, matrix2, "Matrixes created two ways should be equal")
    }
    
    func testMatrixCreation2() {
        let matrix1 = Matrix([[1,2,3], [5,6,7]])
        //let matrix2: Matrix = [[1,2,3], [5,6,7]]
    }
    
    func testAddition() {
        let a = Matrix([1,2,3])
        let b = Matrix([4,5,6])
        let c = a + b
        
        XCTAssertEqual(c, Matrix([5,7,9]), "c should equal [5,7,9]")
    }
    func testAddition2() {
        let a = Matrix([[1,2,3],[4,5,6]])
        let b = Matrix([[4,5,6],[7,8,9]])
        let c = a + b
        
        XCTAssertEqual(c, Matrix([[5,7,9],[11,13,15]]), "c should equal [5,7,9]")
    }
    func testSubtraction() {
        let a = Matrix([1,2,3])
        let b = Matrix([4,5,6])
        let c = a - b
        
        XCTAssertEqual(c, Matrix([-3,-3,-3]), "c should equal [-3,-3,-3]")
    }
    func testSubtraction2() {
        let a = Matrix([[1,2,3],[4,5,6]])
        let b = Matrix([[4,5,6],[7,8,9]])
        let c = a - b
        
        XCTAssertEqual(c, Matrix([[-3,-3,-3],[-3,-3,-3]]), "c should equal [[-3,-3,-3],[-3,-3,-3]]")
    }

    func testShape() {
        let a = Matrix([1,2,3])
        XCTAssert(a.shape.r == 1, "a should only have the one row")
        XCTAssert(a.shape.c == 3, "a should only have three columns")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
