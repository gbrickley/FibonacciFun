//
//  SuperIntCalculator.swift
//  Fibonacci Fun
//
//  Created by George Brickley on 8/17/18.
//  Copyright © 2018 George Brickley. All rights reserved.
//

import Foundation
import BigNumber

class SuperIntCalculator {
    
    /**
     Adds two SuperInt's
     - Parameter int1: The first int to add.
     - Parameter int2: The second int to add.
     - returns: The sum, as a SuperInt
     */
    func sum(of int1: SuperInt, and int2: SuperInt) -> SuperInt {
        
        if let basicInt1 = int1.intValue, let basicInt2 = int2.intValue {
            return sumBasicInts(int1: basicInt1, int2: basicInt2)
        }
        
        if let bigInt1 = int1.bigInt, let bigInt2 = int2.bigInt {
            return sumBigInts(int1: bigInt1, int2: bigInt2)
        }
            
        if let bigInt = int1.bigInt, let basicInt = int2.intValue {
            return sumBigInts(int1: bigInt, int2: BInt(basicInt))
        }
            
        if let basicInt = int1.intValue, let bigInt = int2.bigInt {
            return sumBigInts(int1: BInt(basicInt), int2: bigInt)
        }
        
        // Should never get here
        return SuperInt(withInt: 0)
    }
}


// MARK: Private Methods
extension SuperIntCalculator {
    
    private func sumBasicInts(int1: UInt, int2: UInt) -> SuperInt {
        
        // We have to make sure the sum does not overflow.  If it does, use BigInts
        // If the sum overflows, use BigInts instead
        let result = int1.addingReportingOverflow(int2)
        if (result.overflow || result.partialValue > Int.max) {
            return sumBigInts(int1: BInt(int1), int2: BInt(int2))
        } else {
            return SuperInt(withInt: result.partialValue)
        }
    }
    
    private func sumBigInts(int1: BInt, int2: BInt) -> SuperInt {
        let sum = int1 + int2
        return SuperInt(withBigInt: sum)
    }
}


