//
//  Double+Fib.swift
//  Fibonacci Fun
//
//  Created by George Brickley on 8/19/18.
//  Copyright © 2018 George Brickley. All rights reserved.
//

import Foundation

extension Double {
    
    /// Rounds the double to given decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
