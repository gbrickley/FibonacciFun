//
//  FibonacciCalculationResult.swift
//  Fibonacci Fun
//
//  Created by George Brickley on 8/17/18.
//  Copyright © 2018 George Brickley. All rights reserved.
//

import Foundation
import BigNumber

class FibonacciCalculationResult {
    
    /// The sequences output values.  The key for each value is the input value
    var sequence: [SuperInt]
    
    /// The time that the actual sequence calculation took
    var calculationTime: TimeInterval
    
    init(withSequence sequence: [SuperInt], and calculationTime: TimeInterval) {
        self.sequence = sequence
        self.calculationTime = calculationTime
    }
    
    func printDetails() {
        for (input, output) in sequence.enumerated() {
            print("f(\(input)): \(output.stringRepresentation())")
        }
        print("Execution Time: \(calculationTime)")
    }
}
