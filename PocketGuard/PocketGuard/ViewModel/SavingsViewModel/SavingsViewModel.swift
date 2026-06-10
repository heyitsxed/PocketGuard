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
    
    @Published var profileObjects: [SavingProfile] = []
    @Published var balance: Double = 0
    
    private let service = TransactionService()
    
    var totalAmount: Double {
        profileObjects.reduce(0) { $0 + $1.amount }
    }
    
    var totalSaved: Double {
        profileObjects.reduce(0) { $0 + $1.saved }
    }
    
    func loadData() {
        let objects = service.fetchProfiles()
        profileObjects = objects.map { SavingProfile(object: $0) }
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
    
    func createGoal(name: String, amount: Double, saved: Double, image: UIImage?, date: Date) {
        do {
            try service.createProfile(name: name, amount: amount, saved: saved, image: image, date: date)
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
