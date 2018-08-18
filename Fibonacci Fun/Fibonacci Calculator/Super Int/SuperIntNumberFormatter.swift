//
//  SuperIntNumberFormatter.swift
//  Fibonacci Fun
//
//  Created by George Brickley on 8/17/18.
//  Copyright © 2018 George Brickley. All rights reserved.
//

import UIKit

class SuperIntNumberFormatter: NumberFormatter {
    
    // Using the formatter as a singleton in order to save on resources
    static let sharedInstance = SuperIntNumberFormatter()
    
    override init() {
        super.init()
        self.locale = NSLocale.current
        self.maximumFractionDigits = 0
        self.minimumFractionDigits = 0
        self.numberStyle = NumberFormatter.Style.decimal
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
