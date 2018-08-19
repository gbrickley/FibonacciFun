//
//  UIViewController+Fib.swift
//  Fibonacci Fun
//
//  Created by George Brickley on 8/18/18.
//  Copyright © 2018 George Brickley. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// Present an alert with a give title and message
    func presentAlertWith(title: String?, and message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
