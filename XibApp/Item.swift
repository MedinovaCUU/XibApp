//
//  Item.swift
//  XibApp
//
//  Created by Ricardo Montañez Miranda on 08/09/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
