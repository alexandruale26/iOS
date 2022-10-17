//
//  ContentView.swift
//  WeSplit
//
//  Created by Alexandru Tenie on 02.10.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var amount = 0.0 
    @State private var numberOfPeople = 2
    @State private var percentage = 10
    @FocusState private var isFocused: Bool
    var currencyFormat: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    
    var totalPerPerson: Double {
        return grandTotal / Double(numberOfPeople + 2)
    }
    var tipValue: Double {
        return (amount * Double(percentage) / 100)
    }
    var grandTotal: Double {
        return amount + tipValue
    }
    
    var noTip: Bool {
        return percentage == 0
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $amount, format: currencyFormat)
                        .font(.largeTitle)
                        .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification)) { obj in
                            if let textField = obj.object as? UITextField {
                                textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
                            }
                        }
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(0 ..< 98)
                        {
                            Text("\($0 + 2) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $percentage){
                        ForEach(0 ..< 101)
                        {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("TIP PERCENTAGE")
                }
                
                Section {
                    Text(totalPerPerson, format: currencyFormat)
                } header: {
                    Text("Amount per person")
                }
                .foregroundColor(.mint)
                
                Section {
                    Text(tipValue, format: currencyFormat)
                } header: {
                    Text("Tip value")
                }
                .foregroundColor(.mint)
                
                Section {
                    Text(grandTotal, format: currencyFormat)
                } header: {
                    Text("Grand total")
                }
                .foregroundColor(noTip ? .red : .mint)
            }
            .navigationTitle(("We | Split"))
            .toolbar {
                ToolbarItemGroup(placement: .keyboard)
                {
                    Spacer()
                    Button("Done") {
                        isFocused.toggle()
                    }
                }
            }
        }
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
