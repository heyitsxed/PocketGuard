//
//  UserDefaultsManager.swift
//  PocketGuard
//
//  Created by Cedrick on 4/15/26.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    private enum Keys {
        static let amounts: String = "amounts"
    }
    
    var amounts: [Double] {
        get { defaults.array(forKey: Keys.amounts) as? [Double] ?? [] }
        set { defaults.set(newValue, forKey: Keys.amounts) }
    }
}
