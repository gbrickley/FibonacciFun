//
//  FibonacciCalculationResult.swift
//  Fibonacci Fun
//
//  Created by George Brickley on 8/17/18.
//  Copyright © 2018 George Brickley. All rights reserved.
//

import Foundation
import BigNumber

class FibonacciCalculationResult: NSObject, NSCoding {

    /// The sequences output values.  The key for each value is the input value
    var sequence: [SuperInt]
    
    /// The time that the actual sequence calculation took
    var calculationTime: TimeInterval
    
    init(withSequence sequence: [SuperInt], and calculationTime: TimeInterval) {
        self.sequence = sequence
        self.calculationTime = calculationTime
    }
    
    /// The n value used to generate the sequence
    func upperBound() -> UInt {
        return UInt(sequence.count - 1)
    }
    
    // MARK: - Coding
    
    required init?(coder aDecoder: NSCoder) {
        self.sequence = aDecoder.decodeObject(forKey: "sequence") as! [SuperInt]
        self.calculationTime = aDecoder.decodeDouble(forKey: "calculationTime")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(sequence, forKey: "sequence")
        aCoder.encode(calculationTime, forKey: "calculationTime")
    }
}
