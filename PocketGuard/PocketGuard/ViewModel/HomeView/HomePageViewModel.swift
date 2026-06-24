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
    private let storage = UserDefaultsManager.shared

    @Published var isShowPopup: Bool = false
    @Published var isAmountHidden: Bool = false
    @Published var selectedIndex: Int? = nil
    
    @Published var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
}
