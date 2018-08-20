//
//  HomeViewController.swift
//  Fibonacci Fun
//
//  Created by George Brickley on 8/17/18.
//  Copyright © 2018 George Brickley. All rights reserved.
//

import UIKit
import MPNumericTextField
import EmptyDataSet_Swift
import MBProgressHUD

class HomeViewController: UIViewController {
    
    // The Fibonacci calculator that will be doing the actual calculation work
    let calculator = FibonacciCalculator()
    
    // This array will hold our most recently calculated sequence
    var sequence = [SuperInt]()
    
    // The history manager adds
    let historyManager = CalculationHistoryManager.sharedInstance
    
    // The time it took to calculate the most recent sequence
    var calculationTime: TimeInterval?
    
    // If we encountered an error while calculating the most recent sequence, we'll store it here
    var errorMessage: String?
    
    // The progress indicator we'll use when loading
    var progressHUD: MBProgressHUD?
    
    // UI Elements
    @IBOutlet weak var upperBoundTextField: MPNumericTextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calculationTimeContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var calculationTimeContainerView: UIView!
    @IBOutlet weak var calculationTimeLabel: UILabel!
    
    // Constraint constants
    let defaultCalculationTimeContainerHeight: CGFloat = 44
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUpperBoundTextField()
        updateCalculationTimeDisplayState(animated: false)
    }
}

// MARK: - Private Methods
private extension HomeViewController {
    
    func calculateSequence(to upperBound: UInt) {
        
        // Double check that we have a valid n value
        guard upperBound > 0 else {
            presentAlertWith(title: "Error", and: "Please enter an upper bound value greater than 0.")
            return
        }
        
        // Clear any existing search data
        sequence = []
        calculationTime = nil
        errorMessage = nil
        
        // Hide the text field keyboard
        upperBoundTextField.resignFirstResponder()
        
        // Show a loading view
        showLoadingViewWithMesage("Calculating...")
        
        // Permform the actual calculations
        calculator.calculateFibonacciSequence(endingAt: upperBound, completion: { result in
            
            self.hideLoadingView()
            
            switch result {
                
            case .success(let result):
                self.sequence = result.sequence
                self.calculationTime = result.calculationTime
                self.historyManager.add(result: result)
                
            case .error( _, let description):
                self.errorMessage = description
            }
            
            // Reload the view regardless of the result
            self.tableView.reloadData()
            self.scrollTableViewToTop(animated: false)
            self.updateCalculationTimeDisplayState(animated: true)
        })
    }
    
    func setupTableView() {
        tableView.hideEmptyCells()
        tableView.emptyDataSetSource = self
        tableView.userDynamicCellHeightsWith(estimatedHeight: 44)
    }
    
    func setupUpperBoundTextField() {
        upperBoundTextField.type = MPNumericTextFieldType.integer
        upperBoundTextField.placeholder = "Enter an upper bound to calculate"
        
        let numberToolbar: UIToolbar = UIToolbar()
        numberToolbar.barStyle = UIBarStyle.black
        
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.didRequestToCloseKeyboard(_:)))
        cancelBtn.tintColor = UIColor.white
        
        let goBtn = UIBarButtonItem(title: "Start Calculation", style: .plain, target: self, action: #selector(self.didRequestToBeginCalculations(_:)))
        goBtn.tintColor = UIColor.white
        
        let centeringSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        numberToolbar.items = [cancelBtn, centeringSpace, goBtn]
        numberToolbar.sizeToFit()
        upperBoundTextField.inputAccessoryView = numberToolbar
    }
    
    @objc func didRequestToBeginCalculations(_ sender: UIBarButtonItem) {
        calculateSequence(to: currentEnteredUpperBound())
    }
    
    @objc func didRequestToCloseKeyboard(_ sender: UIBarButtonItem) {
        upperBoundTextField.resignFirstResponder()
    }
    
    func currentEnteredUpperBound() -> UInt {
        return UInt(upperBoundTextField.numericValue.intValue)
    }
    
    // MARK: Table View
    
    func scrollTableViewToTop(animated: Bool)
    {
        if (sequence.count > 0) {
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.scrollToRow(at: indexPath, at: .top, animated: animated)
        }
    }

    // MARK: Loading View
    
    func showLoadingViewWithMesage(_ message: String?) {
        tableView.isHidden = true
        progressHUD = MBProgressHUD.showAdded(to: view, animated: true)
        progressHUD?.label.text = message
    }
    
    func hideLoadingView() {
        tableView.isHidden = false
        progressHUD?.hide(animated: true)
    }
    
    // MARK: Calculation Time
    
    func updateCalculationTimeDisplayState(animated: Bool) {
        if let calculationTime = calculationTime {
            showCalculationTime(calculationTime, animated: animated)
        } else {
            hideCalculationTimeDisplay(animated: animated)
        }
    }
    
    func showCalculationTime(_ calculationTime: TimeInterval, animated: Bool) {
        calculationTimeLabel.text = "Calculated in \(calculationTime.milliseconds()) milliseconds"
        
        let duration = animated ? 0.3 : 0
        UIView.animate(withDuration: duration, animations: {
            self.calculationTimeContainerHeight.constant = self.defaultCalculationTimeContainerHeight
            self.view.layoutIfNeeded()
        })
    }
    
    func hideCalculationTimeDisplay(animated: Bool) {
        
        let duration = animated ? 0.3 : 0
        UIView.animate(withDuration: duration, animations: {
            self.calculationTimeContainerHeight.constant = 0
            self.view.layoutIfNeeded()
        })
    }
}

// MARK: - Table View Data Source
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sequence.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sequenceCell", for: indexPath) as! SequenceCell
        
        cell.inputLabel.text = "𝑓(\(indexPath.row))"
        cell.outputLabel.text = sequence[indexPath.row].stringRepresentation()
        return cell
    }
}


// MARK: - Table View Delegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


// MARK: - Empty Data Set Source
extension HomeViewController: EmptyDataSetSource {
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        var title = ""
        if errorMessage != nil {
            title = "Calculation Error"
        } else {
            title = "Start Calculating!"
        }
        
        let atts = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)]
        return NSAttributedString.init(string: title, attributes: atts)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        var descrip = ""
        if let errorMessage = errorMessage {
            descrip = "Error: \(errorMessage)"
        } else {
            descrip = "Enter an upper bound (n) to calculate the Fibonacci sequence from 0 to n."
        }
        
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
