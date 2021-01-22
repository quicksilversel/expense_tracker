//
//  ViewController.swift
//  expense_tracker
//
//  Created by Zoe L on 2021/01/21.
//

import UIKit

class ViewController: UIViewController, MyDataSendingDelegateProtocol {

    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var balanceDisplay: UILabel!
    @IBOutlet weak var incomeDisplay: UILabel!
    @IBOutlet weak var expenseDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // calculate current balance
        UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "incomeBalance") - UserDefaults.standard.integer(forKey: "expenseBalance"), forKey: "currentBalance")
        
        // display balance
        balanceDisplay.text = "¥" + String(UserDefaults.standard.integer(forKey: "currentBalance"))
        expenseDisplay.text = "¥" + String( UserDefaults.standard.integer(forKey: "expenseBalance"))
        incomeDisplay.text = "¥" + String(UserDefaults.standard.integer(forKey: "incomeBalance"))
        
        // display current date
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        currentDate.text = formatter.string(from: date)
        
        // Do any additional setup after loading the view.
    }
    
    // initialze balance on first day of month
    func initBalance(){
        let defaults = UserDefaults.standard
        defaults.set(0, forKey: "currentBalance")
        defaults.set(0, forKey: "expenseBalance")
        defaults.set(0, forKey: "incomeBalance")
    }
    
    // update expense
    func updateExpense(expenseAmount: String) {
        let updatedExpense:Int = Int(expenseAmount)! + UserDefaults.standard.integer(forKey: "expenseBalance")
        UserDefaults.standard.set(updatedExpense, forKey: "expenseBalance")
        viewDidLoad()
    }
    
    // update income
    func updateIncome(incomeAmount: String) {
        let updatedIncome: Int = Int(incomeAmount)! + UserDefaults.standard.integer(forKey: "incomeBalance")
        UserDefaults.standard.set(updatedIncome, forKey: "incomeBalance")
        viewDidLoad()
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "addInput" {
           let secondVC: inputFieldViewController = segue.destination as! inputFieldViewController
           secondVC.delegate = self
       }
   }

  

}

