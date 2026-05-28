//
//  CreateGoalView.swift
//  PocketGuard
//
//  Created by Cedrick on 4/21/26.
//

import SwiftUI
import PhotosUI

struct CreateGoalView: View {
    @Environment(\.dismiss)  var dismiss
    
    @State var name: String
    @State var amount: Double
    @State var savedAmount: Double
    @State var selectedDate = Date()
    
    @State var selectedItem: PhotosPickerItem?
    @State var selectedImage: UIImage?
    @State var onSavePlan: ((SavingProfile) -> Void)?
    
    @State var showPicker: Bool = false
    @State var isEditingGoalAmount = false
    @State var isEditingSavedAmount = false
    
    @State var goalAmountText: String = ""
    @State var savedAmountText: String = ""
    
    @FocusState private var isEditingGoalAmountFocused: Bool
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack {
            NavigationStack {
                Form {
                    Section(StringEnums.growYourSavings.rawValue) {
                        HStack {
                            VStack {
                                if let image = selectedImage {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 90, height: 90)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                } else {
                                    Image("wallet-icon")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 90, height: 90)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                }
                                
                                Button(StringEnums.changeIcon.rawValue) {
                                    print("change icon")
                                    showPicker = true
                                }
                                .photosPicker(isPresented: $showPicker, selection: $selectedItem, matching: .images)
                                .onChange(of: selectedItem) { oldValue, newValue in
                                    guard let item = newValue else { return }
                                    Task {
                                        if let data = try? await item.loadTransferable(type: Data.self),
                                           let uiImage = UIImage(data: data) {
                                            selectedImage = uiImage
                                        }
                                    }
                                }
                            }
                            
                            VStack(alignment: .leading) {
                                Text(StringEnums.startSavingHere.rawValue)
                                    .font(.system(size: 15, weight: .semibold, design: .default))
                                    .foregroundColor(.gray)
                                
                                TextField(StringEnums.enterSavingName.rawValue, text: $name)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                        }
                    }
                    
                    Section(StringEnums.financialDetails.rawValue) {
                        HStack {
                            Text(StringEnums.pesoSign.rawValue)
                            
                            if isEditingGoalAmount {
                                TextField(StringEnums.goalAmount.rawValue, text: $goalAmountText)
                                    .keyboardType(.numberPad)
                                    .focused($isEditingGoalAmountFocused)
                                    .onAppear {
                                        if goalAmountText.isEmpty {
                                            goalAmountText = amount == 0 ? "" : String(format: "%.0f", amount)
                                        }
                                        
                                        isEditingGoalAmountFocused = true
                                    }
                                    .onChange(of: goalAmountText) { oldValue, newValue in
                                        amount = Double(newValue) ?? 0
                                    }
                            } else {
                                Text(amount == 0 ? StringEnums.goalAmount.rawValue : "\(StringEnums.pesoSign.rawValue)\(amount)")
                                    .foregroundColor(amount == 0 ? .gray : .primary)
                                    .onTapGesture {
                                        isEditingGoalAmount = true
                                    }
                            }
                        }
                        
                        HStack {
                            Text(StringEnums.pesoSign.rawValue)
                            
                            if isEditingSavedAmount {
                                TextField(StringEnums.savedAmountOptional.rawValue, text: $savedAmountText)
                                    .keyboardType(.numberPad)
                                    .focused($isFocused)
                                    .onAppear {
                                        savedAmountText = savedAmount == 0 ? "" : "\(savedAmount)"
                                        isFocused = true
                                    }
                                    .onSubmit {
                                        savedAmount = Double(savedAmountText) ?? 0
                                        isEditingSavedAmount = false
                                    }
                                    .onChange(of: savedAmountText) { oldValue, newValue in
                                        savedAmount = Double(newValue) ?? 0
                                    }
                                
                            } else {
                                Text(savedAmount == 0 ? StringEnums.savedAmountOptional.rawValue : "\(StringEnums.pesoSign.rawValue)\(savedAmount)")
                                    .foregroundColor(savedAmount == 0 ? .gray : .primary)
                                    .onTapGesture {
                                        isEditingSavedAmount = true
                                    }
                            }
                        }     .keyboardType(.numberPad)
                    }
                    
                    Section(StringEnums.targetDate.rawValue) {
                        DatePicker(StringEnums.setATargetDate.rawValue, selection: $selectedDate, displayedComponents: .date)
                        
                    }
                    
                    HStack {
                        Button(StringEnums.savedPlan.rawValue) {
                            let progress = amount == 0 ? 0 : savedAmount / amount
                            let finalImage = selectedImage ?? UIImage(named: "wallet-icon")!
                            let newSavedPlan = SavingProfile(name: name, progress: progress, amount: amount, image: finalImage)
                            
                            guard !name.isEmpty, amount != 0, savedAmount <= amount else {
                                return
                            }
                            
                            onSavePlan?(newSavedPlan)
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
                .navigationTitle(StringEnums.newSavings.rawValue)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
