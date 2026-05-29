//
//  Date+Extension.swift
//  PocketGuard
//
//  Created by Cedrick on 5/29/26.
//

import Foundation

extension Date {
    func formattedShort() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}
