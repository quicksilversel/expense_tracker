//
//  transactionData.swift
//  expense_tracker
//
//  Created by Zoe L on 2021/01/22.
//

import Foundation

class TransactionItem: NSObject {
    var date: String
    var amount: String
    
    public init(date: String, amount: String){
        self.date = date
        self.amount = amount
    }
    
    init(coder decoder: NSCoder) {
        self.date = decoder.decodeObject(forKey: "date") as! String
        self.amount = decoder.decodeObject(forKey: "amount") as! String
    }

    func encodeWithCoder(coder: NSCoder) {
        coder.encode(self.date, forKey: "date")
        coder.encode(self.amount, forKey: "amount")
    }
}
