//
//  HistoryViewController.swift
//  Fibonacci Fun
//
//  Created by George Brickley on 8/18/18.
//  Copyright © 2018 George Brickley. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift

class HistoryViewController: UIViewController {
    
    // This array will hold our results history
    var history = [FibonacciCalculationResult]()

    // UI Elements
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadHistory()
    }
}

// MARK: - Private Methods
extension HistoryViewController {
    
    func setupTableView() {
        tableView.hideEmptyCells()
        tableView.emptyDataSetSource = self
    }
    
    func loadHistory() {
        history = CalculationHistoryManager.sharedInstance.calculationHistory()
    }
}

// MARK: - Table View Data Source
extension HistoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryCell
        
        let result = history[indexPath.row]
        cell.upperBoundLabel.text = "n: \(result.upperBound())"
        cell.calculationTimeLabel.text = "\(result.calculationTime.milliseconds()) ms"
        return cell
    }
}


// MARK: - Table View Delegate
extension HistoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


// MARK: - Empty Data Set Source
extension HistoryViewController: EmptyDataSetSource {
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let title = "No Calculations Made Yet"
        let atts = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)]
        return NSAttributedString.init(string: title, attributes: atts)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let descrip = "Once you make some calculations, we'll display them here."
        let atts = [NSAttributedStringKey.foregroundColor: UIColor.gray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)]
        return NSAttributedString.init(string: descrip, attributes: atts)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "fib-spiral")
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return -100
    }
}
