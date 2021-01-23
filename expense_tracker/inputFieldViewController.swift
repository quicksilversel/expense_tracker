//
//  inputFieldViewController.swift
//  expense_tracker
//
//  Created by Zoe L on 2021/01/21.
//

import UIKit

protocol MyDataSendingDelegateProtocol {
    func updateExpense(transDate: String, expenseAmount: String)
    func updateIncome(transDate: String, incomeAmount: String)
}

class inputFieldViewController: UIViewController {
    
    @IBOutlet weak var inputAmount: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate: MyDataSendingDelegateProtocol? = nil
    
    // default value
    var inputStatus: String = "expense"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
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
            // return date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy"
            let date = dateFormatter.string(from: self.datePicker.date)
            // return amount
            let amount = self.inputAmount.text
            // delegate
            self.delegate?.updateExpense(transDate: date, expenseAmount: amount!)
            dismiss(animated: true, completion: nil)
        }
        // income
        else if self.delegate != nil && inputStatus == "income" {
            // return date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy"
            let date = dateFormatter.string(from: self.datePicker.date)
            // return amount
            let amount = self.inputAmount.text
            // delegate
            self.delegate?.updateIncome(transDate: date, incomeAmount: amount!)
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

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
