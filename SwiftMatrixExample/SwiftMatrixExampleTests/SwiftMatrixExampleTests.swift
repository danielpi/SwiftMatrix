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
        let matrix = Matrix(rows: 2, cols: 2)
        XCTAssertEqualWithAccuracy(matrix[0,0], 0.0, DBL_EPSILON, "All Values should be 0.0")
        XCTAssertEqualWithAccuracy(matrix[1,0], 0.0, DBL_EPSILON, "All Values should be 0.0")
        XCTAssertEqualWithAccuracy(matrix[0,1], 0.0, DBL_EPSILON, "All Values should be 0.0")
        XCTAssertEqualWithAccuracy(matrix[1,1], 0.0, DBL_EPSILON, "All Values should be 0.0")
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
        XCTAssertEqual(matrix1, Matrix([[1,2,3], [5,6,7]]), "2x3 matrices")
    }
    
    func testOnesCreation() {
        let a = Matrix(rows: 3, cols: 3, repeatedValue: 1.0)
        let b = ones(3,3)
        XCTAssertEqual(a, b, "Testing the two methods of making a matrix full of 1.0")
        XCTAssertEqual(a, Matrix([[1,1,1],[1,1,1],[1,1,1]]), "Making sure that there are actually 1.0's in there")
    }
    
    func testZerosCreation() {
        let a = zeros(1,4)
        XCTAssertEqual(a, Matrix([0,0,0,0]), "Testing an array of zeros")
    }
    
    func testEyeCreation() {
        let a = eye(3)
        XCTAssertEqual(a, Matrix([[1,0,0],[0,1,0],[0,0,1]]), "Testing an identity matrix")
    }
    
    func testRandCreation() {
        let a = rand(2,3)
        XCTAssertEqual(a.rows, 2, "Just checking that a correctly sized matrix was created")
        XCTAssertEqual(a.cols, 3, "Just checking that a correctly sized matrix was created")
        // TODO: Test random values properly
    }
    func testRandnCreation() {
        let a = randn(2,3)
        XCTAssertEqual(a.rows, 2, "Just checking that a correctly sized matrix was created")
        XCTAssertEqual(a.cols, 3, "Just checking that a correctly sized matrix was created")
        // TODO: Test random values properly
    }
    func testRandnMeanCreation() {
        let a = randn(2, 3, mean: 10, sigma: 1)
        XCTAssertEqual(a.rows, 2, "Just checking that a correctly sized matrix was created")
        XCTAssertEqual(a.cols, 3, "Just checking that a correctly sized matrix was created")
        // TODO: Test random values properly
    }
    func testSubscription() {
        let a:Matrix = Matrix([[0,1,2,3],[4,5,6,7],[8,9,10,11],[12,13,14,15]])
        //println(a)
        XCTAssertEqual(a[2,2], 10.0, "Two Int subscripts identify a single value")
        XCTAssertEqual(a[9], 9.0, "Single Int subscript also access a single value")
        XCTAssertEqual(a[[2,3],[0,3]], Matrix([[8,11],[12,15]]), "Array subscripts pick out specific elements and return another matrix")
        // How do I select an entire row or column?
        XCTAssertEqual(a[0...2, 0...3], Matrix([[0,1,2,3],[4,5,6,7],[8,9,10,11]]), "Using ranges for slicing")
    }
    
    func testSubscriptionSync() {
        let a: Matrix = Matrix([[0,1,2,3],[4,5,6,7],[8,9,10,11],[12,13,14,15]])
        let b = Matrix([[4.0,3],[6,5]])
        println(a)
        println(b)
        
        //a[[0,1],[2,3]] = Matrix([[4.0,3],[6,5]])
        
        XCTAssertEqual(a, Matrix([[0,1,3,3],[4,5,6,5],[8,9,10,11],[12,13,14,15]]), "Testing that we can set values via subscription")
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
    func testAddition3() {
        let a = Matrix([[1,2,3],[4,5,6]])
        let b = a + 5
        let c = 5 + a
        XCTAssertEqual(b, Matrix([[6,7,8],[9,10,11]]), "Adding a Double")
        XCTAssertEqual(c, Matrix([[6,7,8],[9,10,11]]), "Adding a Double")
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
    
    func testScalarMultiplication() {
        let a = Matrix([1,2,3])
        let b = Matrix([[4,5,6],[7,8,9]])
        
        let c = 3 * a
        let d = -1 * b
        let e = b * 0.1
        
        let f = Matrix([[0.4, 0.5, 0.6],[0.7, 0.8, 0.9]])
        XCTAssertEqual(c, Matrix([3,6,9]), "c should equal ")
        XCTAssertEqual(d, Matrix([[-4,-5,-6],[-7,-8,-9]]), "c should equal ")
        XCTAssertEqual(e, Matrix([[0.4, 0.5, 0.6],[0.7, 0.8, 0.9]]), "c should equal")
    }

    func testSize() {
        let a = Matrix([1,2,3])
        XCTAssert(a.size.rows == 1, "a should only have the one row")
        XCTAssert(a.size.cols == 3, "a should only have three columns")
    }
    
    func testTranspose() {
        let a = Matrix([[1,2,3],[4,5,6]])
        XCTAssertEqual(a.transpose(), Matrix([[1,4],[2,5],[3,6]]), "Transpose of a 3x2 matrix")
        XCTAssertEqual(a.T, Matrix([[1,4],[2,5],[3,6]]), "Transpose of a 3x2 matrix")
        XCTAssertEqual(a⊺, Matrix([[1,4],[2,5],[3,6]]), "Transpose of a 3x2 matrix")
    }
    
    func testPrintOut() {
        let a = Matrix([[1,2,3],[4,5,6]])
        println(a)
        let b = randn(9, 5)
        println(b)
        let c = randn(20, 20, mean: 10, sigma: 10)
        println(c)
    }
    
    func testPerformanceOfCreation() {
        self.measureBlock() {
            // Put the code you want to measure the time of here.
            let a = Matrix(rows: 1000, cols: 10)
        }
    }
    
    func testPerformanceOfTranspose() {
        // This is an example of a performance test case.
        
        self.measureBlock() {
            // Put the code you want to measure the time of here.
            let a = Matrix(rows: 1000, cols: 10)
            a.T
        }
    }
    
}
