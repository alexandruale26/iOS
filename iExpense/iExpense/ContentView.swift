//
//  ContentView.swift
//  iExpense
//
//  Created by Alexandru Tenie on 28.10.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var personlExpenses: [ExpenseItem] {
        expenses.items.filter {$0.type == "Personal"}
    }
    
    var businessExpenses: [ExpenseItem] {
        expenses.items.filter {$0.type == "Business"}
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(personlExpenses.count > 0 ? "Personal" : "") {
                    ForEach(personlExpenses) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            if #available(iOS 16, *) {
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            } else {
                                Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                            }
                        }
                    }
                    .onDelete(perform: removePersonalExpenses)
                }
                
                Section(businessExpenses.count > 0 ? "Business" : "") {
                    ForEach(businessExpenses) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            if #available(iOS 16, *) {
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            } else {
                                Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                            }
                        }
                    }
                    .onDelete(perform: removeBusinessExpenses)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removePersonalExpenses(at offsets: IndexSet) {
        for offset in offsets {
            if let index = expenses.items.firstIndex(where: {$0.id == personlExpenses[offset].id}) {
                expenses.items.remove(at: index)
            }
        }
    }
    
    func removeBusinessExpenses(at offsets: IndexSet) {
        for offset in offsets {
            if let index = expenses.items.firstIndex(where: {$0.id == businessExpenses[offset].id}) {
                expenses.items.remove(at: index)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
