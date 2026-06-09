//
//  EditView.swift
//  PocketGuard
//
//  Created by Cedrick on 6/9/26.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var vm: SavingsViewModel
    @Binding var path: [Route]
    
    let profile: SavingProfile
    
    @State private var isEditing: Bool = false
    @State private var amount: Double = 0.0
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(StringEnums.savingInfo.rawValue) {
                        Text(profile.name)
                    }
                    
                    Section(StringEnums.financialDetails.rawValue) {
                        if isEditing {
                            TextField(StringEnums.amount.rawValue, value: $amount, format: .currency(code: "PHP"))
                                .keyboardType(.numberPad)
                                .onSubmit {
                                    isEditing = false
                                }
                        } else {
                            Text("₱\(Text(profile.amount, format: .number.precision(.fractionLength(2))))")
                                .onTapGesture {
                                    amount = profile.amount
                                    isEditing = true
                                }
                        }
                    }
                    
                    Section(StringEnums.targetDate.rawValue) {
                        Text(profile.date, style: .date)
                    }
                    
                    Button(StringEnums.deleteGoal.rawValue) {
                        vm.delete(profile)
                        path.removeAll()
                        dismiss()
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle(StringEnums.editSaving.rawValue)
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}
