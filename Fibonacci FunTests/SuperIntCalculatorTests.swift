//
//  SuperIntCalculatorTests.swift
//  Fibonacci FunTests
//
//  Created by George Brickley on 8/17/18.
//  Copyright © 2018 George Brickley. All rights reserved.
//

import XCTest
import BigNumber
@testable import Fibonacci_Fun

class SuperIntCalculatorTests: XCTestCase {
    
    var calculator: SuperIntCalculator!
    
    override func setUp() {
        calculator = SuperIntCalculator()
        super.setUp()
    }
    
    override func tearDown() {
        calculator = nil
        super.tearDown()
    }
    
    func testSumTwoBasicIntsWithoutOverflow() {

        // If:
        let int1 = SuperInt(withInt: 10)
        let int2 = SuperInt(withInt: 20)
        
        // When:
        let calculatedInt = calculator.sum(of: int1, and: int2)
        
        // Then:
        let expectedDefaultInt: UInt = 30
        XCTAssertNil(calculatedInt.bigInt)
        XCTAssertEqual(calculatedInt.intValue, expectedDefaultInt)
    }
    
    func testSumTwoBasicIntsWithOverflow() {
        
        // If:
        let int1 = SuperInt(withInt: 18446744073709551614)
        let int2 = SuperInt(withInt: 2)
        
        // When:
        let calculatedInt = calculator.sum(of: int1, and: int2)

        // Then:
        let expectedBigInt = BInt("18446744073709551616")
        XCTAssertNil(calculatedInt.intValue)
        XCTAssertEqual(calculatedInt.bigInt, expectedBigInt)
    }
    
    func testSumTwoBigInts() {
        
        // If:
        let bigInt1 = BInt("18446744073709551616")
        let bigInt2 = BInt("18446744073709551618")
        
        let int1 = SuperInt(withBigInt: bigInt1!)
        let int2 = SuperInt(withBigInt: bigInt2!)
        
        // When:
        let calculatedInt = calculator.sum(of: int1, and: int2)
        
        // Then:
        let expectedBigInt = BInt("36893488147419103234")
        XCTAssertNil(calculatedInt.intValue)
        XCTAssertEqual(calculatedInt.bigInt, expectedBigInt)
    }
    
    func testSumBasicAndBigIntComboA() {
        
        // If:
        let int1 = SuperInt(withInt: 100)
        let int2 = SuperInt(withBigInt: BInt("18446744073709551616")!)
        
        // When:
        let calculatedInt = calculator.sum(of: int1, and: int2)
        
        // Then:
        let expectedBigInt = BInt("18446744073709551716")
        XCTAssertNil(calculatedInt.intValue)
        XCTAssertEqual(calculatedInt.bigInt, expectedBigInt)
    }
    
    func testSumBasicAndBigIntComboB() {
        
        // If:
        let int1 = SuperInt(withBigInt: BInt("18446744073709551616")!)
        let int2 = SuperInt(withInt: 100)
        
        // When:
        let calculatedInt = calculator.sum(of: int1, and: int2)
        
        // Then:
        let expectedBigInt = BInt("18446744073709551716")
        XCTAssertNil(calculatedInt.intValue)
        XCTAssertEqual(calculatedInt.bigInt, expectedBigInt)
    }
}
