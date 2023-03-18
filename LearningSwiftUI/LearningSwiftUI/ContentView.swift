//
//  ContentView.swift
//  LearningSwiftUI
//
//  Created by Дмитрий Пермяков on 19.03.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = ""
    @State private var countPeopleIndex = 2
    @State private var percentageForWaiter = 0
    
    private let percatages:[Int] = [0, 5, 10, 15, 20]
    private var grandTotal: Double {
        var res = Double(amount) ?? 0
        let percetageTip = Double(percatages[percentageForWaiter])
        res += (res * percetageTip) / 100.0
        print("Я тут")
        return res / Double(countPeopleIndex + 2)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Сумма") {
                    TextField("Сумма чека", text: $amount)
                        .keyboardType(.numberPad)
                }
                Section("Количество людей") {
                    Picker("Число людей", selection: $countPeopleIndex) {
                        ForEach(2..<51) {
                            Text("\($0) чел")
                        }
                    }
                }
                Section(header: Text("Сколько чаевых вы хотите оставить?")
                    .font(.caption)) {
                    Picker("На чай", selection: $percentageForWaiter) {
                        ForEach(0..<percatages.count) {
                            Text("\(self.percatages[$0])%")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Итог с каждого") {
                    Text("\(grandTotal, specifier: "%.2f") руб.")
                }
            }
            .navigationBarTitle("Калькулятор чаевых", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
