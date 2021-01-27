//
//  monthlyData.swift
//  expense_tracker
//
//  Created by Zoe L on 2021/01/27.
//

import Foundation

struct YearMonth: Hashable {
    let year: Int
    let month: Int

    init(year: Int, month: Int) {
        self.year = year
        self.month = month
    }

    init(date: Date) {
        let comps = Calendar.current.dateComponents([.year, .month], from: date)
        self.year = comps.year!
        self.month = comps.month!
    }

    var hashValue: Int {
        return year * 12 + month
    }

}

// dictionary to store data
var monthlyData = [YearMonth: Int]()


