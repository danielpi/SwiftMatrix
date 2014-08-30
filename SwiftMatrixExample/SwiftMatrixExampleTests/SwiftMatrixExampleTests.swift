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
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
