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
    
    @State private var isEditing: Bool = false
    @State private var amount: Double = 0.0
    
    let profile: SavingProfile
    let dailyGoal: Double
    let remainingDays: String
    let progress: CGFloat
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
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
                        .shadow(color: .indigo.opacity(0.3), radius: 4, x: 0, y: 2)
                }
                
                Spacer()
                
                VStack(spacing: 4) {
                    Text("Edit Saving Goal")
                        .font(.headline)
                        .foregroundStyle(.primary)
                    
                    Text("Update your goal details and stay on track")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                
                Spacer()
                
                Color.clear
                    .frame(width: 34, height: 34)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color(.systemBackground))
            
            Form {
                Section {
                    Text(profile.name)
                        .font(.body)
                        .padding(.vertical, 2)
                } header: {
                    sectionHeader(title: "Saving Name", subtitle: "Give your saving name.", systemIcon: "tag")
                }
                
                Section {
                    let amount = profile.amount
                    Text("₱\(amount, format: .number.precision(.fractionLength(2)))")
                        .font(.body)
                        .fontWeight(.semibold)
                        .padding(.vertical, 2)
                } header: {
                    sectionHeader(title: "Goal Amount", subtitle: "How much do you want to save?", systemIcon: "pesosign.circle.fill")
                }
                
                Section {
                    Text(profile.date, style: .date)
                        .font(.body)
                        .padding(.vertical, 2)
                } header: {
                    sectionHeader(title: "Target Date", subtitle: "When do you want to reach your goal?", systemIcon: "calendar")
                }
                
                goalMetricsSummaryView
                
                Section {
                    Button(role: .destructive) {
                        vm.delete(profile)
                        path.removeAll()
                        dismiss()
                    } label: {
                        HStack {
                            Spacer()
                            Text(StringEnums.deleteGoal.rawValue)
                                .fontWeight(.medium)
                            
                            Spacer()
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func sectionHeader(title: String, subtitle: String, systemIcon: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: systemIcon)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.green)
                .frame(width: 24, height: 24)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                Text(subtitle)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.leading, -4)
        .textCase(nil)
    }
    
    private var goalMetricsSummaryView: some View {
        ZStack {
            Color.white
                .shadow(color: Color.black.opacity(0.06), radius: 16, x: 0, y: 8)
            
            HStack {
                Spacer()
                
                VStack(spacing: 5) {
                    Image(systemName: "target").foregroundColor(.green)
                    Text("Daily Needed").font(.system(size: 11, weight: .semibold))
                    Text(dailyGoal, format: .currency(code: "PHP")).font(.system(size: 9, weight: .semibold))
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                Divider().frame(height: 50)
                Spacer()
                
                VStack(spacing: 5) {
                    Image(systemName: "checkmark.shield.fill").foregroundColor(.green)
                    Text("Time Left").font(.system(size: 11, weight: .semibold))
                    Text(remainingDays)
                        .font(.system(size: 9))
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                Divider().frame(height: 50)
                Spacer()
                
                VStack(spacing: 5) {
                    Image(systemName: "chart.bar").foregroundColor(.green)
                    Text("Goal Progress").font(.system(size: 11, weight: .semibold))
                    Text("\(Text(progress * 100, format: .number.precision(.fractionLength(2))))%")
                        .font(.system(size: 9))
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
            }
        }
        .frame(height: 60)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.horizontal, 15)
        .padding(.bottom, 15)
    }
}
