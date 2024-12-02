//
//  Goal.swift
//  Krriya
//
//  Created by Shwait Kumar on 02/12/24.
//

import Foundation
import SwiftData

@Model
class Goal {
    @Attribute(.unique) var id: UUID
    var title: String
//    var description: String?
    var isCurrent: Bool
    var colorComboTitleRawValue: String // Represents the `title` in `ColorCombination`
    var createdAt: Date
    var completedAt: Date?
    
    // Reconstruct `ColorCombination` dynamically
     var colorCombination: ColorCombination {
         get { ColorCombinations.shared.getCombination(for: colorComboTitleRawValue) ?? ColorCombinations.shared.defaultCombination }
         set { colorComboTitleRawValue = newValue.title.rawValue }
     }
    
    init(title: String, isCurrent: Bool, colorCombo: ColorCombination, createdAt: Date = Date(), completedAt: Date? = nil) {
        self.id = UUID()
        self.title = title
//        self.description = description
        self.isCurrent = isCurrent
        self.colorComboTitleRawValue = colorCombo.title.rawValue
        self.createdAt = createdAt
        self.completedAt = completedAt
    }
}

// Use for creating goal. This is same as Goal but to avoid any coupling issues later with data stored locally, we have decided to use this new model
class GoalInput: ObservableObject {
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var isCurrent: Bool = true
    @Published var colorCombination: ColorCombination = ColorCombinations.shared.defaultCombination
    @Published var createdAt: Date = Date()
    @Published var completedAt: Date? = nil
}
