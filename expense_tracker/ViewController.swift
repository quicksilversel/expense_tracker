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
        
        // initialize balance on first day of month
        if Calendar.current.component(.day, from: Date()) == 1 {
            initBalance()
        }
        
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
    
    // initialze balance
    func initBalance(){
        let defaults = UserDefaults.standard
        defaults.set(0, forKey: "currentBalance")
        defaults.set(0, forKey: "expenseBalance")
        defaults.set(0, forKey: "incomeBalance")
    }
    
    // update expense
    func updateExpense(transDate: String, expenseAmount: String) {
        let updatedExpense:Int = Int(expenseAmount)! + UserDefaults.standard.integer(forKey: "expenseBalance")
        UserDefaults.standard.set(updatedExpense, forKey: "expenseBalance")
        
        // add entry to table
        
        TransactionItem.init(date: transDate, amount: expenseAmount)
        
        viewDidLoad()
    }
    
    // update income
    func updateIncome(transDate: String, incomeAmount: String) {
        let updatedIncome: Int = Int(incomeAmount)! + UserDefaults.standard.integer(forKey: "incomeBalance")
        UserDefaults.standard.set(updatedIncome, forKey: "incomeBalance")
        viewDidLoad()
    }
    
    // table view
    /* override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicStyleCell", for: indexPath)

    }
    */
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "addInput" {
           let secondVC: inputFieldViewController = segue.destination as! inputFieldViewController
           secondVC.delegate = self
       }
   }

  

}

