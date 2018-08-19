//
//  TimeInterval+Fib.swift
//  Fibonacci Fun
//
//  Created by George Brickley on 8/18/18.
//  Copyright © 2018 George Brickley. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    /// The TimeInterval converted to a double
    func milliseconds() -> Double {
        let ms = truncatingRemainder(dividingBy: 1) * 1000
        let rounded = ms.rounded(toPlaces: 6)
        return rounded
    }
}


