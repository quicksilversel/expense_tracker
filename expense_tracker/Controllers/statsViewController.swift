//
//  statsViewController.swift
//  expense_tracker
//
//  Created by Zoe L on 2021/01/27.
//

import UIKit
import Firebase

class statsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: Properties
    var statsCategory = [String]() // get category from firebase
    let ref = Database.database().reference(withPath:"transaction-data") // firebase
    
    // MARK: Outlets
    
    @IBOutlet weak var currentMonth: UILabel!
    @IBOutlet weak var currentSum: UILabel!
    @IBOutlet weak var expenseCategory: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()

        // display month
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        currentMonth.text = formatter.string(from: date)
        // display sum
        let year = Calendar.current.component(.year, from: Date())
        let month = Calendar.current.component(.month, from: Date())
        let sum = monthlyData[YearMonth(year:year, month:month)]
        currentSum.text = "¥" + String(sum ?? 0)
        
        // display table
        expenseCategory.delegate = self
        expenseCategory.dataSource = self
        
        // calculate amount by iterating 
        ref.observe(.value, with: { snapshot in
          var newItems: [String] = []
            for child in snapshot.children.allObjects {
            if let snapshot = child as? DataSnapshot,
               let item = snapshot.key as? String {
              newItems.append(item)
            }
          }
          self.statsCategory = newItems
          self.expenseCategory.reloadData()
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.statsCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statsCategory", for: indexPath)
        cell.textLabel?.text = self.statsCategory[indexPath.row]
        return cell
    }
    
}
