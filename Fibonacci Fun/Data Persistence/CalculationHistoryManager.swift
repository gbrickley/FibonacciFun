//
//  CalculationHistoryManager.swift
//  Fibonacci Fun
//
//  Created by George Brickley on 8/18/18.
//  Copyright © 2018 George Brickley. All rights reserved.
//

import Foundation

class CalculationHistoryManager {
    
    // History manager uses the singleton pattern
    static let sharedInstance = CalculationHistoryManager()
    
    // Where our results are actually stored
    private var history = [FibonacciCalculationResult]()
    
    init() {
        // On first load, retrieve any locally saved data
        history = locallySavedHistory()
    }
    
    func add(result: FibonacciCalculationResult) {
        history.insert(result, at: 0)
        persistHistoryLocally()
    }
    
    func calculationHistory() -> [FibonacciCalculationResult] {
        return history
    }
}


// MARK: - Private Methods
extension CalculationHistoryManager {
    
    private func persistHistoryLocally() {
        NSKeyedArchiver.archiveRootObject(history, toFile: savePath())
    }
    
    private func locallySavedHistory() -> [FibonacciCalculationResult] {

        if let historyData = NSKeyedUnarchiver.unarchiveObject(withFile: savePath()) as? [FibonacciCalculationResult] {
            return historyData
        } else {
            return []
        }
    }
    
    private func savePath() -> String {
        let file = "history"
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        return url!.appendingPathComponent(file).path
    }
}

