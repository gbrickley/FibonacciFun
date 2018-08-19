//
//  FibNumber.swift
//  Fibonacci Fun
//
//  Created by George Brickley on 8/17/18.
//  Copyright © 2018 George Brickley. All rights reserved.
//

import Foundation
import BigNumber

class SuperInt: NSObject, NSCoding {
    
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
    
    /**
     A foramtted string representing the value.
     - returns: String
     */
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

    /**
     Whether or not this is a 'big int' meaning the value exceeds that max allowed in a UInt
     - returns: Bool
     */
    func isBigInt() -> Bool {
        return bigInt != nil
    }
    
    // MARK: - Coding
    
    required init?(coder aDecoder: NSCoder) {
        
        if let intStr = aDecoder.decodeObject(forKey: "intValue") as? String {
            self.intValue = UInt(intStr)
        } else {
            self.intValue = nil
        }
        
        if let bigIntString = aDecoder.decodeObject(forKey: "bigInt") as? String {
            self.bigInt = BInt(bigIntString)
        } else {
            self.bigInt = nil
        }
    }
    
    func encode(with aCoder: NSCoder) {
        let intStr = (intValue != nil) ? String(intValue!) : nil
        aCoder.encode(intStr, forKey: "intValue")
        aCoder.encode(bigInt?.description, forKey: "bigInt")
    }
}
