//
//  categoryViewController.swift
//  expense_tracker
//
//  Created by Zoe L on 2021/01/25.
//

import UIKit

protocol CategoryDelegateProtocol {
    func getCategory(category: String)
}

class categoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var categoryTableView: UITableView!
    
    // MARK: variables
    var categories: [String] = ["Groceries", "Shopping", "Transportation", "Entertainment", "Eating Out", "Rent"]
    
    var delegate: CategoryDelegateProtocol? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTableView.register(UITableViewCell.self,
                               forCellReuseIdentifier: "categoryCell")
        
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
        categoryTableView.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = self.categories[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = self.categories[indexPath.row]
        self.delegate?.getCategory(category: selectedCategory)
        dismiss(animated: true, completion: nil)
    }
    
    

}
