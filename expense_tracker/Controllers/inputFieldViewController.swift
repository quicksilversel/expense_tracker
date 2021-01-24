//
//  inputFieldViewController.swift
//  expense_tracker
//
//  Created by Zoe L on 2021/01/21.
//

import UIKit

protocol MyDataSendingDelegateProtocol {
    func updateExpense(transDate: String, expenseAmount: String, notes: String, category: String)
    func updateIncome(transDate: String, incomeAmount: String, notes: String, category: String)
}

class inputFieldViewController: UIViewController, CategoryDelegateProtocol {
    // MARK: Outlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var inputAmount: UITextField!
    @IBOutlet weak var notes: UITextField!
    @IBOutlet weak var inputCategory: UIButton!
    
    // MARK: Variables
    var delegate: MyDataSendingDelegateProtocol? = nil
    var inputStatus: String = "expense" // set to expense by default
    var categoryInput: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // MARK: Actions
    // done button
    @IBAction func finishInput(_ sender: Any) {
        // alert if textfield is empty
        if self.inputAmount.text?.isEmpty == true {
            let alertController = UIAlertController(title: "Error", message: "please enter an amount", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title:"OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated:true, completion:nil)}
        // expense
        else if self.delegate != nil && inputStatus == "expense"
        {
            // date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy"
            let date = dateFormatter.string(from: self.datePicker.date)
            // amount
            let amount = self.inputAmount.text
            // notes
            let notes = self.notes.text!
            // delegate
            self.delegate?.updateExpense(transDate: date, expenseAmount: amount!, notes: notes, category: categoryInput)
            dismiss(animated: true, completion: nil)
        }
        // income
        else if self.delegate != nil && inputStatus == "income" {
            // date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy"
            let date = dateFormatter.string(from: self.datePicker.date)
            // amount
            let amount = self.inputAmount.text
            // notes
            let notes = self.notes.text!
            // delegate
            self.delegate?.updateIncome(transDate: date, incomeAmount: amount!, notes: notes, category: categoryInput)
            dismiss(animated: true, completion: nil)
        }
    }
    
    // cancel button
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // income expense segmented control
    @IBAction func segmentedControl(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex{
        case 0: inputStatus = "expense";
        case 1: inputStatus = "income";
        default: break;
        }
    }
    
    func getCategory(category: String) {
        categoryInput = category
        inputCategory.setTitle(category, for: .normal)
    }
    
    // segue
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "addCategory" {
           let secondVC: categoryViewController = segue.destination as! categoryViewController
           secondVC.delegate = self
       }
   }
}
