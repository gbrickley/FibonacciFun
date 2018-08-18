//
//  FibonacciCalculatorTests.swift
//  Fibonacci FunTests
//
//  Created by George Brickley on 8/17/18.
//  Copyright © 2018 George Brickley. All rights reserved.
//

import XCTest
@testable import Fibonacci_Fun

class FibonacciCalculatorTests: XCTestCase {
    
    var calculator: FibonacciCalculator!
    
    override func setUp() {
        calculator = FibonacciCalculator()
        super.setUp()
    }
    
    override func tearDown() {
        calculator = nil
        super.tearDown()
    }
    
    /*
    func testCalculatorWithBasicUpperBound() {

        let upperBound: UInt = 5
        let expectation = self.expectation(description: "calls the callback with response")
        let int1 = SuperInt(withInt: 0)
        let expectedSequence:[SuperInt] = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610]

        calculator.calculateFibonacciSequence(endingAt: upperBound, completion: { result in
            
            switch result {
                
            case .success(let result):
                result.printDetails()
                XCTAssertEqual(result.sequence, expectedSequence)
                
            case .error(let code, let description):
                XCTAssert(false, "Returned error [\(code)]: \(description)")
            }
            
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 3, handler: .none)
    }
    
    func testCalculatorWithZeroValue() {
        
        let upperBound: UInt = 0
        let expectation = self.expectation(description: "calls the callback with response")
        let expectedSequence:[UInt] = [0]
        
        calculator.calculateFibonacciSequence(endingAt: upperBound, completion: { result in
            
            switch result {
                
            case .success(let result):
                XCTAssertEqual(result.sequence, expectedSequence)
                
            case .error(let code, let description):
                XCTAssert(false, "Returned error [\(code)]: \(description)")
            }
            
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 3, handler: .none)
    }
    
    func testCalculatorSpeed() {

        self.measure {
            
            let upperBound: UInt = 10000
            let expectation = self.expectation(description: "calls the callback with response")
            
            calculator.calculateFibonacciSequence(endingAt: upperBound, completion: { result in
                expectation.fulfill()
            })
            
            self.waitForExpectations(timeout: 10, handler: .none)
        }
    }
    */
    
}
