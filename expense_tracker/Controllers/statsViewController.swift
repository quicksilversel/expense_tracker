//
//  statsViewController.swift
//  expense_tracker
//
//  Created by Zoe L on 2021/01/27.
//

import UIKit
import Firebase
import Charts

class statsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: variables
    var statsCategory = [String: Int]() // get category from firebase
    let ref = Database.database().reference(withPath:"transaction-data")
    var keyArray = [String]()
    var valueArray = [Int]()
    
    // MARK: Outlets
    @IBOutlet weak var currentMonth: UILabel!
    @IBOutlet weak var currentSum: UILabel!
    @IBOutlet weak var expenseCategory: UITableView!
    @IBOutlet weak var pieChart: PieChartView!

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
        var sum = monthlyData[YearMonth(year:year, month:month)]
        currentSum.text = "¥" + String(UserDefaults.standard.integer(forKey: "currentBalance"))
        
        // display table
        expenseCategory.delegate = self
        expenseCategory.dataSource = self
        
        ref.queryOrdered(byChild: "category").observe(.value, with: { snapshot in
            var newItems = [String: Int]()
            var actualData = [String]()
            var intData = [Int]()
            for child in snapshot.children.allObjects {
            if let snapshot = child as? DataSnapshot,
               let item = snapshot.key as? String {
                for nestedChild in snapshot.children {
                    if let nestedSnapshot = nestedChild as? DataSnapshot,
                       let nestedItem = nestedSnapshot.childSnapshot(forPath: "amount").value as? String {
                        actualData.append(nestedItem)
                        intData = actualData.compactMap{ Int($0) }
                        sum = intData.reduce(0, +)
                        newItems[item] = sum // add to dictonary
                    }
                }
                actualData.removeAll() // initialze array
            }
          }
            self.statsCategory = newItems
            for (key, value) in self.statsCategory
            {
                self.keyArray.append(key)
                self.valueArray.append(value)
            }
            self.expenseCategory.reloadData()
            // pie chart
            self.customizeChart(dataPoints: self.keyArray, values: self.valueArray.map{ Double($0) })

        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.statsCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statsCategory", for: indexPath)
        cell.textLabel?.text = keyArray[indexPath.row]
        cell.detailTextLabel?.text = "¥" +  String(valueArray[indexPath.row])
        return cell
    }
    
    // pie chart
    func customizeChart(dataPoints: [String], values: [Double]) {
        var dataEntries = [ChartDataEntry]()
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
                dataEntries.append(dataEntry)
        }
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        pieChartData.setDrawValues(false)
        pieChart.data = pieChartData
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
      var colors: [UIColor] = []
      for _ in 0..<numbersOfColor {
        let red = Double(arc4random_uniform(256))
        let green = Double(arc4random_uniform(256))
        let blue = Double(arc4random_uniform(256))
        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        colors.append(color)
      }
      return colors
    }

}


