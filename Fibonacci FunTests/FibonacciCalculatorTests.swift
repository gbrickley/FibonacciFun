//
//  FibonacciCalculatorTests.swift
//  Fibonacci FunTests
//
//  Created by George Brickley on 8/17/18.
//  Copyright © 2018 George Brickley. All rights reserved.
//

import XCTest
import BigNumber
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
    
    func testCalculatorWithBasicUpperBound() {

        let upperBound: UInt = 5
        let expectation = self.expectation(description: "calls the callback with response")
        let expectedLast = SuperInt(withInt: 5).stringRepresentation()

        calculator.calculateFibonacciSequence(endingAt: upperBound, completion: { result in
            
            switch result {
                
            case .success(let result):
                let calculatedLast = result.sequence.last?.stringRepresentation()
                XCTAssertEqual(calculatedLast, expectedLast)
                
            case .error(let code, let description):
                XCTAssert(false, "Returned error [\(code)]: \(description)")
            }
            
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 3, handler: .none)
    }
    
    func testCalculatorWithUpperBoundCausingOverflow() {
        
        let upperBound: UInt = 100
        let expectation = self.expectation(description: "calls the callback with response")
        let expectedLast = SuperInt(withBigInt: BInt("354224848179261915075")!).stringRepresentation()
        
        calculator.calculateFibonacciSequence(endingAt: upperBound, completion: { result in
            
            switch result {
                
            case .success(let result):
                let calculatedLast = result.sequence.last?.stringRepresentation()
                XCTAssertEqual(calculatedLast, expectedLast)
                
            case .error(let code, let description):
                XCTAssert(false, "Returned error [\(code)]: \(description)")
            }
            
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 3, handler: .none)
    }
    
    func testCalculatorWithLargeUpperBound() {
        
        let upperBound: UInt = 1000
        let expectation = self.expectation(description: "calls the callback with response")
        let val = "43466557686937456435688527675040625802564660517371780402481729089536555417949051890403879840079255169295922593080322634775209689623239873322471161642996440906533187938298969649928516003704476137795166849228875"
    
        let expectedLast = SuperInt(withBigInt: BInt(val)!).stringRepresentation()
        
        calculator.calculateFibonacciSequence(endingAt: upperBound, completion: { result in
            
            switch result {
                
            case .success(let result):
                let calculatedLast = result.sequence.last?.stringRepresentation()
                XCTAssertEqual(calculatedLast, expectedLast)
                
            case .error(let code, let description):
                XCTAssert(false, "Returned error [\(code)]: \(description)")
            }
            
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 3, handler: .none)
    }
    
    func testCalculatorSpeed() {

        self.measure {
            
            let upperBound: UInt = 100
            let expectation = self.expectation(description: "calls the callback with response")
            
            calculator.calculateFibonacciSequence(endingAt: upperBound, completion: { result in
                expectation.fulfill()
            })
            
            self.waitForExpectations(timeout: 10, handler: .none)
        }
    }

}
