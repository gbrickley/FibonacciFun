//
//  FibNumber.swift
//  Fibonacci Fun
//
//  Created by George Brickley on 8/17/18.
//  Copyright © 2018 George Brickley. All rights reserved.
//

import Foundation
import BigNumber

class SuperInt {
    
    let intValue: UInt?
    let bigInt: BInt?

    init(withInt int: UInt) {
        self.intValue = int
        self.bigInt = nil
    }
    
    init(withBigInt int: BInt) {
        self.bigInt = int
        self.intValue = nil
    }
    
    func isBigInt() -> Bool {
        return bigInt != nil
    }
        
    func stringRepresentation() -> String {
        
        if let intValue = intValue {
            let formatter = SuperIntNumberFormatter.sharedInstance
            return formatter.string(from: NSNumber.init(value: intValue)) ?? "N/A"
        } else if let bigInt = bigInt {
            return "\(bigInt.description.withNumberStyleCommasAdded())"
        } else {
            return "N/A"
        }
    }
}
