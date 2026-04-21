//
//  CreateGoalView.swift
//  PocketGuard
//
//  Created by Cedrick on 4/21/26.
//

import SwiftUI


struct CreateGoalView: View {
    @Environment(\.dismiss)  var dismiss
    
    @State var name: String = ""
    @State var amount: Double?
    @State var savedAmount: Double?
    @State var selectedDate = Date()
    
    var body: some View {
        VStack {
            NavigationStack {
                Form {
                    Section(StringEnums.goalInfo.rawValue) {
                        TextField(StringEnums.enterGoalName.rawValue, text: $name)
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.blue)
                            .frame(width: 90, height: 90)
                            
                        Button(StringEnums.changeIcon.rawValue) {
                            print("change icon")
                        }
                    }
                    
                    Section(StringEnums.financialDetails.rawValue) {
                        HStack {
                            Text(StringEnums.pesoSign.rawValue)
                                .fontWeight(.regular)
                            
                            TextField(StringEnums.goalAmount.rawValue, value: $amount, format: .currency(code: "PHP"))
                                .keyboardType(.numberPad)
                        }
                        
                        HStack {
                            Text(StringEnums.pesoSign.rawValue)
                                .fontWeight(.regular)
                            
                            TextField(StringEnums.savedAmountOptional.rawValue, value: $savedAmount, format: .currency(code: "PHP"))
                                .keyboardType(.numberPad)
                        }
                    }
                    
                    Section(StringEnums.targetDate.rawValue) {
                        DatePicker(StringEnums.setATargetDate.rawValue, selection: $selectedDate, displayedComponents: .date)
                        
                    }
                    
                    HStack {
                        Button(StringEnums.savedGoal.rawValue) {
                            print("save goal")
                        }
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
                .navigationTitle(StringEnums.newgoal.rawValue)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
