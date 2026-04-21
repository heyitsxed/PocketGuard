//
//  SavingsView.swift
//  PocketGuard
//
//  Created by Cedrick on 4/20/26.
//

struct SavingProfile: Identifiable {
    let id = UUID()
    let name: String
    let progress: Double
    let amount: Double
}

import SwiftUI

struct SavingsView: View {
    @State var container: [SavingProfile] = []
    @State private var isCreateNewGoal: Bool = false
    
    var body: some View {
        NavigationStack {
            List(container) { item in
                HStack {
                    CustomProgressBarView(name: item.name, progress: item.progress, amount: item.amount)
                }
            }
            .listStyle(.insetGrouped)
            
            Button {
                isCreateNewGoal = true
            } label: {
                Text(StringEnums.addGoal.rawValue)
            }
            .navigationTitle(StringEnums.myGoals.rawValue)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        
                    } label: {
                        Image(systemName: "person.fill")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Text(StringEnums.edit.rawValue)
                        .font(.system(size: 17))
                        .padding()
                }
            }
            .fullScreenCover(isPresented: $isCreateNewGoal) {
                CreateGoalView()
            }
        }
    }
}

#Preview {
    SavingsView()
}

