//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Alexandru Tenie on 28.10.2022.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
