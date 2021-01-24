//
//  transactionData.swift
//  expense_tracker
//
//  Created by Zoe L on 2021/01/22.
//

import Foundation
import Firebase

class TransactionItem {
    
    let ref: DatabaseReference?
    var timestamp: Double
    var date: String
    var amount: String
    
    init(date: String, amount: String){
        self.ref = nil
        self.date = date
        self.amount = amount
        self.timestamp = 0
    }
    
    init?(snapshot: DataSnapshot) {
      guard
        let value = snapshot.value as? [String: AnyObject],
        let date = value["date"] as? String,
        let amount = value["amount"] as? String,
        let timestamp = value["timestamp"] as? Double else {
        return nil
      }
    self.ref = snapshot.ref
    self.date = date
    self.amount = amount
    self.timestamp = timestamp
    }
    
    // turn into dictionary
    func toAnyObject() -> Any {
      return [
        "date": date,
        "amount": amount,
        "timestamp": [".sv": "timestamp"]
      ]
    }
}
