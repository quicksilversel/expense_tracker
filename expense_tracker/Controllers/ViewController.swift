//
//  ViewController.swift
//  expense_tracker
//
//  Created by Zoe L on 2021/01/21.
//

import UIKit
import Firebase

class ViewController: UIViewController, MyDataSendingDelegateProtocol, UITableViewDelegate, UITableViewDataSource {
    // MARK: Outlets
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var balanceDisplay: UILabel!
    @IBOutlet weak var incomeDisplay: UILabel!
    @IBOutlet weak var expenseDisplay: UILabel!
    @IBOutlet weak var transactionDataTableView: UITableView!
    
   // MARK: Variables
    var transactionDataArr = [TransactionItem]()
    let ref = Database.database().reference(withPath: "transaction-data") // firebase
    

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
        
        // synchronize data to table view from firebase
        ref.observe(.value, with: { snapshot in
          var newItems: [TransactionItem] = []
          for child in snapshot.children {
            if let snapshot = child as? DataSnapshot {
                for nestedChild in snapshot.children {
                    if let nestedSnapshot = nestedChild as? DataSnapshot,
                       let nestedItem = TransactionItem(snapshot:nestedSnapshot) {
                        newItems.append(nestedItem)
                    }
                }
            }
          }
            self.transactionDataArr = newItems
            self.transactionDataTableView.reloadData()
        })


        // Do any additional setup after loading the view.
    }
        
    
    // initialze balance and store to monthlyData table
    func initBalance(){
        // save to dictionary
        let currentYear = Calendar.current.component(.year, from: Date())
        let currentMonth = Calendar.current.component(.month, from: Date())
        monthlyData[YearMonth(year: currentYear, month:currentMonth)] = UserDefaults.standard.integer(forKey: "expenseBalance")
        // initialize current month balance
        let defaults = UserDefaults.standard
        defaults.set(0, forKey: "currentBalance")
        defaults.set(0, forKey: "expenseBalance")
        defaults.set(0, forKey: "incomeBalance")
    }
    
    // update expense
    func updateExpense(transDate: String, expenseAmount: String, notes: String, category: String) {
        let updatedExpense:Int = Int(expenseAmount)! + UserDefaults.standard.integer(forKey: "expenseBalance")
        UserDefaults.standard.set(updatedExpense, forKey: "expenseBalance")
        // add entry to table
        let item = TransactionItem(date: transDate, amount:  expenseAmount, notes: notes, category: category)
        let itemRef = self.ref.child(category).childByAutoId()
        itemRef.setValue(item.toAnyObject())
        
        // transactionDataArr.append(TransactionItem(date: transDate, amount: "-¥" + expenseAmount))
        // transactionDataTableView.reloadData()
        
        viewDidLoad()
        
    }
    
    // update income
    func updateIncome(transDate: String, incomeAmount: String, notes: String, category: String) {
        let updatedIncome: Int = Int(incomeAmount)! + UserDefaults.standard.integer(forKey: "incomeBalance")
        UserDefaults.standard.set(updatedIncome, forKey: "incomeBalance")
        // add entry to table
        let item = TransactionItem(date: transDate, amount: incomeAmount, notes: notes, category: category)
        let itemRef = self.ref.child(category).childByAutoId()
        itemRef.setValue(item.toAnyObject())
        
        // transactionDataArr.append(TransactionItem(date: transDate, amount: "+¥" + incomeAmount))
        // transactionDataTableView.reloadData()
        
        viewDidLoad()
    }

    // UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return transactionDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionDataTableViewCell", for: indexPath) as! transactionDataTableViewCell
        cell.dateCell.text = transactionDataArr[indexPath.row].date
        cell.amountCell.text = "¥" + transactionDataArr[indexPath.row].amount
        
        if transactionDataArr[indexPath.row].notes.isEmpty == true {
            cell.notesCell.text = transactionDataArr[indexPath.row].category
        }
        else {
            cell.notesCell.text = transactionDataArr[indexPath.row].notes
        }
        return cell
    }
    
    // segue
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "addInput" {
        let destinationNavigationController = segue.destination as! UINavigationController
        let targetController = destinationNavigationController.topViewController as! inputFieldViewController
           targetController.delegate = self
       }
   }
    
}

