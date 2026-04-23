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
    @State var showPicker: Bool = false
    @State var onSavePlan: ((SavingProfile) -> Void)?
    
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
                        Button(StringEnums.savedPlan.rawValue) {
                            let progress = amount == 0 ? 0 : savedAmount / amount
                            let finalImage = selectedImage ?? UIImage(named: "wallet-icon")!
                            let newSavedPlan = SavingProfile(name: name, progress: progress, amount: amount, image: finalImage)
                            
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
