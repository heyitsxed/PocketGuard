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
    
    @State private var name: String = ""
    @State private var amount: Double = 0.0
    @State private var targetDate: Date = Date()
    
    let profile: SavingProfile
    let dailyGoal: Double
    let remainingDays: String
    let progress: CGFloat
    
    var body: some View {
        VStack {
            headerView.frame(height: 60)
            
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Image(systemName: "tag")
                        .font(.system(size: 19, weight: .medium))
                        .foregroundStyle(.green)
                        .frame(width: 24, height: 24)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(StringEnums.savingName.rawValue)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.black)
                        
                        Text(StringEnums.savingNameSubtitle.rawValue)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.black)
                    }
                }
                .padding(.horizontal, 15)
                
                customCard {
                    TextField(StringEnums.enterName.rawValue, text: $name)
                }
            }.padding(.vertical, 5)
            
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Image(systemName: "target")
                        .font(.system(size: 19, weight: .medium))
                        .foregroundStyle(.green)
                        .frame(width: 24, height: 24)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(StringEnums.goalAmount.rawValue)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.black)
                        
                        Text(StringEnums.goalNameSubtitle.rawValue)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.black)
                    }
                }
                .padding(.horizontal, 15)
                
                customCard {
                    TextField(StringEnums.enterAmount.rawValue, value: $amount, format: .number)
                        .keyboardType(.decimalPad)
                }
            }.padding(.vertical, 5)
            
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Image(systemName: "calendar")
                        .font(.system(size: 19, weight: .medium))
                        .foregroundStyle(.green)
                        .frame(width: 24, height: 24)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(StringEnums.targetDate.rawValue)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.black)
                        
                        Text(StringEnums.targetDateSubtitle.rawValue)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.black)
                    }
                }
                .padding(.horizontal, 15)
                
                customCard {
                    HStack {
                        Text(StringEnums.changeDate.rawValue)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.black)
                        
                        Spacer()
                        
                        DatePicker("", selection: $targetDate, displayedComponents: .date)
                            .labelsHidden()
                    }
                }
            }.padding(.vertical, 5)
            
            
            goalMetricsSummaryView
            
            Spacer()
            
            Button {
                saveChanges()
            } label: {
                Text(StringEnums.saveChanges.rawValue)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal, 15)
            
            Button(role: .destructive) {
                vm.delete(profile)
                path.removeAll()
                dismiss()
            } label: {
                Text(StringEnums.deleteGoal.rawValue)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red.opacity(0.8))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal, 15)
        }
        .onAppear {
            setupInitialValues()
        }
    }
}

private extension EditView {
    var headerView: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(
                        LinearGradient(
                            colors: [.blue, .indigo],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .clipShape(Circle())
            }
            
            Spacer()
            
            VStack(spacing: 4) {
                Text(StringEnums.editSavingGoal.rawValue)
                    .font(.headline)
                
                Text(StringEnums.editSavingGoalSubtitle.rawValue)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Color.clear.frame(width: 34)
        }
        .padding()
        .background(Color.white)
    }
    
    func setupInitialValues() {
        name = profile.name
        amount = profile.amount
        targetDate = profile.date
    }
    
    func saveChanges() {
        // You MUST implement this in your VM properly
        //        vm.update(
        //            profile: profile,
        //            name: name,
        //            amount: amount,
        //            date: targetDate
        //        )
        
        dismiss()
    }
}

private extension EditView {
    func customCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading) {
            content()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(Color(.white))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal, 15)
        .shadow(color: Color.black.opacity(0.2), radius: 16, x: 0, y: 8)
        .padding(.vertical, 5)
    }
    
    var goalMetricsSummaryView: some View {
        ZStack {
            Color.white
                .shadow(color: .black.opacity(0.06), radius: 16, x: 0, y: 8)
            
            HStack {
                Spacer()
                
                VStack(spacing: 5) {
                    Image(systemName: "target").foregroundColor(.green)
                    Text(StringEnums.dailyNeeded.rawValue).font(.system(size: 11, weight: .semibold))
                    Text(dailyGoal, format: .currency(code: "PHP"))
                        .font(.system(size: 9))
                }
                
                Spacer()
                Divider().frame(height: 50)
                Spacer()
                
                VStack(spacing: 5) {
                    Image(systemName: "checkmark.shield.fill").foregroundColor(.green)
                    Text(StringEnums.timeLeft.rawValue).font(.system(size: 11, weight: .semibold))
                    Text(remainingDays)
                        .font(.system(size: 9))
                }
                
                Spacer()
                Divider().frame(height: 50)
                Spacer()
                
                VStack(spacing: 5) {
                    Image(systemName: "chart.bar").foregroundColor(.green)
                    Text(StringEnums.goalProgress.rawValue).font(.system(size: 11, weight: .semibold))
                    Text("\(progress * 100, specifier: "%.2f")%")
                        .font(.system(size: 9))
                }
                
                Spacer()
            }
        }
        .frame(height: 70)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.horizontal, 15)
        .shadow(color: Color.black.opacity(0.2), radius: 16, x: 0, y: 8)
    }
}
