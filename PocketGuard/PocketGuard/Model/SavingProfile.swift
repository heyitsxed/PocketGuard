//
//  SavingProfile.swift
//  PocketGuard
//
//  Created by Cedrick on 5/29/26.
//

import Foundation
import RealmSwift
import Realm
import UIKit

class SavingProfileObject: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var amount: Double
    @Persisted var saved: Double
    @Persisted var imageData: Data?
    @Persisted var transactions = List<SavingTransaction>()
}

struct SavingProfile: Identifiable, Hashable {
    let id: String
    let name: String
    let progress: Double
    let amount: Double
    let saved: Double
    let image: UIImage?
    let transactions: [SavingTransaction]
}

extension SavingProfile {
    init(object: SavingProfileObject) {
        self.id = object.id.stringValue
        self.name = object.name
        self.amount = object.amount
        self.saved = object.saved
        self.progress = object.amount == 0 ? 0 : object.saved / object.amount
        self.image = object.imageData.flatMap { UIImage(data: $0) }
        self.transactions = object.transactions.sorted(by: { $0.createdAt > $1.createdAt })
    }
}
