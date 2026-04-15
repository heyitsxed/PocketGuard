//
//  HomePageViewModel.swift
//  PocketGuard
//
//  Created by Cedrick on 4/15/26.
//

import Combine
import SwiftUI

class HomePageViewModel: ObservableObject {
    @Published var amounts: [Double] = UserDefaultsManager.shared.amounts
    
    @Published var selectedIndex: Int? = nil
    
    @Published var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private let storage = UserDefaultsManager.shared
    
    func addRectangle() {
        let amount = Double.random(in: 10...100)
        withAnimation(nil) {
            amounts.append(amount)
            storage.amounts = amounts
        }
    }
}
