//
//  transactionData.swift
//  expense_tracker
//
//  Created by Zoe L on 2021/01/22.
//

import Foundation

class TransactionItem {
    var date: String
    var amount: String
    
    public init(date:String, amount:String){
        self.date = date
        self.amount = "¥" + amount
    }
}
