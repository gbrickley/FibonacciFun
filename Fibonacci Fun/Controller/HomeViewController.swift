//
//  HomeViewController.swift
//  Fibonacci Fun
//
//  Created by George Brickley on 8/17/18.
//  Copyright © 2018 George Brickley. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        runTest()
    }
    
    func runTest() {
        
        /*
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        
        let testVal: Decimal = 354224848179262543210
        print(formatter.string(from: testVal as NSNumber)!)
        //print(formatter.string(from: NSNumber(value: testVal)) ?? "N/A")
        
        let testVal2: Decimal = 354224848179262543201
        print(formatter.string(from: testVal as NSNumber)!)
        //print(formatter.string(from: NSNumber(value: testVal2)) ?? "N/A")
        
        let sum = testVal + testVal2
        print(sum)
        print(formatter.string(from: sum as NSNumber)!)
        //print(formatter.string(from: NSNumber(value: sum)) ?? "N/A")
        */
        
        print(UInt.max)
        
        
        let calculator = FibonacciCalculator()
        calculator.calculateFibonacciSequence(endingAt: 100, completion: { result in
            
            switch result {
                
            case .success(let result):
                result.printDetails()
                
            case .error(let code, let description):
                print("Error [\(code)]: \(description)")
            }
        })
    }
}
