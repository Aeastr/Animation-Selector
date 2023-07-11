//
//  Item.swift
//  AnimationsExamples
//
//  Created by Aether on 11/07/2023.
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
