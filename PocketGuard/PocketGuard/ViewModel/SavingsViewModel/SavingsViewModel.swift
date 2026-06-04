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

@MainActor
class SavingsViewModel: ObservableObject {
    private let realm = try! Realm()

    @Published var transactions: [SavingTransaction] = []
    @Published var profileObjects: [SavingProfileObject] = []
    @Published var balance: Double = 0

    private let service = TransactionService()
    
    func loadData() {
        let objects = service.fetchProfiles()
        profileObjects = Array(objects)
        
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
    
    func addDeposit(amount: Double, to profile: SavingProfileObject) {
        do {
            try service.addDeposit(amount: amount, to: profile)
            loadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addWithdrawal(amount: Double) {
        do {
            try service.addWithdrawal(amount: amount)
            loadData()
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
    
    func delete(_ item: SavingProfileObject) {
        do {
            try service.delete(id: item.id)
            loadData()
        } catch {
            print(error.localizedDescription)
        }
    }
}
