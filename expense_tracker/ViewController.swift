//
//  ViewController.swift
//  expense_tracker
//
//  Created by Zoe L on 2021/01/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var balanceDisplay: UILabel!
    @IBOutlet weak var incomeDisplay: UILabel!
    @IBOutlet weak var expenseDisplay: UILabel!
    
    // get expense amount from expense VC
    var expenseAmount: String = ""
    // get income amount from income VC
    var incomeAmount: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // display balance
        balanceDisplay.text = String(UserDefaults.standard.integer(forKey: "currentBalance"))
        expenseDisplay.text = String( UserDefaults.standard.integer(forKey: "expenseBalance"))
        incomeDisplay.text = String(UserDefaults.standard.integer(forKey: "incomeBalance"))
        
        // display current date
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        currentDate.text = formatter.string(from: date)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addExpense(_ sender: Any) {
        performSegue(withIdentifier: "addInput", sender: self)
    }
    
    // initialize all balance to 0 to if first launched or if start of month
    func initBalance(){
        let defaults = UserDefaults.standard
        defaults.set(0, forKey: "currentBalance")
        defaults.set(0, forKey: "expenseBalance")
        defaults.set(0, forKey: "incomeBalance")
    }
    
    // update expense
    func updateExpense(){
        UserDefaults.standard.set(Int(expenseAmount)! + UserDefaults.standard.integer(forKey: "expenseBalance"), forKey: "expenseBalance")
    }

  

}

