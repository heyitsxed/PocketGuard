//
//  TransactionService.swift
//  PocketGuard
//
//  Created by Cedrick on 6/1/26.
//

import RealmSwift
import UIKit
import Realm

final class TransactionService {
    
    private let realm = try! Realm()
    
    func addDeposit(amount: Double, to profile: SavingProfileObject) throws {
        let realm = try Realm()

        let transaction = SavingTransaction()
        transaction.amount = amount
        transaction.type = .deposit

        try realm.write {
            profile.transactions.append(transaction)
            profile.saved += amount
        }
    }
    
    func addWithdrawal(amount: Double, to profile: SavingProfileObject) throws {
        let transaction = SavingTransaction()
        
        transaction.amount = amount
        transaction.type = .withdrawal
        
        try realm.write {
            profile.transactions.append(transaction)
            profile.saved -= amount
        }
    }
    
    func createProfile(name: String, amount: Double, saved: Double, image: UIImage?) throws {
        let object = SavingProfileObject()
        object.name = name
        object.amount = amount
        object.saved = saved
        object.imageData = image?.jpegData(compressionQuality: 0.8)
        
        try realm.write {
            realm.add(object)
        }
    }
    
    func fetchTransactions() -> Results<SavingTransaction> {
        realm.objects(SavingTransaction.self)
            .sorted(byKeyPath: "createdAt", ascending: false)
    }
    
    func fetchProfiles() -> Results<SavingProfileObject> {
        realm.objects(SavingProfileObject.self)
    }
    
    func delete(id: ObjectId) throws {
        guard let obj = realm.object(ofType: SavingProfileObject.self, forPrimaryKey: id) else { return }

        try realm.write {
            realm.delete(obj)
        }
    }
}
