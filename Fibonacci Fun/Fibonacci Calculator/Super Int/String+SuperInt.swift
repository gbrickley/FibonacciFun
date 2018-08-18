//
//  String+SuperInt.swift
//  Fibonacci Fun
//
//  Created by George Brickley on 8/17/18.
//  Copyright © 2018 George Brickley. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func withNumberStyleCommasAdded() -> String {
        
        var values = [String]()
        var currentSet = ""

        for char in Array(self).reversed() {
            currentSet = "\(char)\(currentSet)"
            if currentSet.count == 3 {
                values.insert(currentSet, at: 0)
                currentSet = ""
            }
        }
        
        if currentSet.count > 0 {
            values.insert(currentSet, at: 0)
        }
        
        return values.joined(separator: ",")
    }
}
