//
//  SavingProfile.swift
//  PocketGuard
//
//  Created by Cedrick on 5/29/26.
//

import Foundation
import UIKit

struct SavingProfile: Identifiable {
    let id = UUID()
    let name: String
    let progress: Double
    let amount: Double
    let saved: Double
    let image: UIImage?
}
