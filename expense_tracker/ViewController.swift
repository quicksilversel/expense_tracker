//
//  ViewController.swift
//  expense_tracker
//
//  Created by Zoe L on 2021/01/21.
//

import UIKit

class ViewController: UIViewController, MyDataSendingDelegateProtocol, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var balanceDisplay: UILabel!
    @IBOutlet weak var incomeDisplay: UILabel!
    @IBOutlet weak var expenseDisplay: UILabel!
    
    @IBOutlet weak var transactionDataTableView: UITableView!
   
    var transactionDataArr = [TransactionItem]()  // transaction data

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
        
        // display table
        transactionDataTableView.delegate = self
        transactionDataTableView.dataSource = self
        
        transactionDataTableView.register(UINib(nibName: "transactionDataTableViewCell", bundle: nil), forCellReuseIdentifier: "transactionDataTableViewCell")

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
        transactionDataArr.append(TransactionItem(date: transDate, amount: "-" + expenseAmount))
        transactionDataTableView.reloadData()
        viewDidLoad()
        
    }
    
    // update income
    func updateIncome(transDate: String, incomeAmount: String) {
        let updatedIncome: Int = Int(incomeAmount)! + UserDefaults.standard.integer(forKey: "incomeBalance")
        UserDefaults.standard.set(updatedIncome, forKey: "incomeBalance")
        // add entry to table
        transactionDataArr.append(TransactionItem(date: transDate, amount: "+" + incomeAmount))
        transactionDataTableView.reloadData()
        viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return transactionDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionDataTableViewCell", for: indexPath) as! transactionDataTableViewCell
        cell.dateCell.text = transactionDataArr[indexPath.row].date
        cell.amountCell.text = transactionDataArr[indexPath.row].amount
        
        return cell
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "addInput" {
           let secondVC: inputFieldViewController = segue.destination as! inputFieldViewController
           secondVC.delegate = self
       }
   }

  

}

