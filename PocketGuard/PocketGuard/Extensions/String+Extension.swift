//
//  String+Extension.swift
//  PocketGuard
//
//  Created by Cedrick on 6/16/26.
//

import SwiftUI

extension String {
    func highlighting(_ subString: String, with color: Color) -> AttributedString {
        var attributed = AttributedString(self)
        if let range = attributed.range(of: subString) {
            attributed[range].foregroundColor = color
        }
        
        return attributed
    }
}
