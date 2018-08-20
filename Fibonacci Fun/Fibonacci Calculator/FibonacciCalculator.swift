//
//  FibonacciCalculator.swift
//  Fibonacci Fun
//
//  Created by George Brickley on 8/17/18.
//  Copyright © 2018 George Brickley. All rights reserved.
//

import Foundation

class FibonacciCalculator {
    
    // Enum generic used to pass data back in completion blocks
    enum Result<T> {
        case success(T)
        case error(code: Int, description: String)
    }
    
    /// Block used to return Fibonacci calculation results
    typealias fibonacciCalculationCompletionBlock = (Result<FibonacciCalculationResult>) -> Void
    
    /**
     Calculates the fibonacci sequence up to a given number.
     - Parameter upperBound: The value to calculate the sequence to
     - Parameter fibonacciCalculationCompletionBlock: The block to be executed when the request finishes
     */
    public func calculateFibonacciSequence(endingAt upperBound: UInt, completion: @escaping fibonacciCalculationCompletionBlock) {

        // We run the actual calc on a background thread
        DispatchQueue.global(qos: .userInitiated).async {

            // This array will hold of fib sequence outputs
            var sequence = [SuperInt]()
            
            // Start monitoring the calculation run time right before we start the calcs
            let start = Date()
            
            // The calculator will help us add integers (handling integer overflow)
            let calculator = SuperIntCalculator()
            
            for n in 0...Int(upperBound) {
                
                // The first 2 values are hardcoded
                // The rest can be calculated from the previous 2
                if n == 0 {
                    sequence.append(SuperInt(withInt: 0))
                } else if n == 1 {
                    sequence.append(SuperInt(withInt: 1))
                } else {
                    // The calculator will automaticaly handle integer overflow
                    sequence.append(calculator.sum(of: sequence[n-1], and: sequence[n-2] ))
                }
            }
            
            // The calculation work is done so stop monitoring here
            let end = Date()
            let calculationTime = end.timeIntervalSince(start)
            
            // Return our results
            let result = FibonacciCalculationResult(withSequence: sequence, and: calculationTime)
            
            // Return on the main thread
            DispatchQueue.main.async {
                completion(Result.success(result))
            }
        }
    }
}
