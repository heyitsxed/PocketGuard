//
//  SavingsViewModel.swift
//  PocketGuard
//
//  Created by Cedrick on 6/1/26.
//

import Combine
import Foundation
import UIKit
import RealmSwift
import SwiftUI

@MainActor
class SavingsViewModel: ObservableObject {
    private let realm = try! Realm()

    @Published var transactions: [SavingTransaction] = []
    @Published var profileObjects: [SavingProfile] = []
    @Published var balance: Double = 0

    private let service = TransactionService()
    
    func loadData() {
        let objects = service.fetchProfiles()
        profileObjects = objects.map { SavingProfile(object: $0) }
        
        balance = transactions.reduce(0) { result, transaction in
            
            switch transaction.type {
            case .deposit:
                return result + transaction.amount
                
            case .withdrawal:
                return result - transaction.amount
            }
        }
    }
    
    func balance(for profile: SavingProfileObject) -> Double {
        profile.transactions.reduce(0) { result, tx in
            switch tx.type {
            case .deposit: return result + tx.amount
            case .withdrawal: return result - tx.amount
            }
        }
    }
    
    func addDeposit(amount: Double, to profile: SavingProfile) {
        do {
            let objectId = try ObjectId(string: profile.id)
            
            if let managedProfile = realm.object(ofType: SavingProfileObject.self, forPrimaryKey: objectId) {
                try service.addDeposit(amount: amount, to: managedProfile)
                loadData()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addWithdrawal(amount: Double, to profile: SavingProfile) {
        do {
            let objectId = try ObjectId(string: profile.id)
            
            if let manageProfile = realm.object(ofType: SavingProfileObject.self, forPrimaryKey: objectId) {
                try service.addWithdrawal(amount: amount, to: manageProfile)
                loadData()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createGoal(name: String, amount: Double, saved: Double, image: UIImage?) {
        do {
            try service.createProfile(name: name, amount: amount, saved: saved, image: image)
            loadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func delete(_ item: SavingProfile) {
        do {
            let objectId = try ObjectId(string: item.id)
            try service.delete(id: objectId)
            
            withAnimation {
                loadData()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
