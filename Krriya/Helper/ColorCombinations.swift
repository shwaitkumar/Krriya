//
//  ColorCombinations.swift
//  Krriya
//
//  Created by Shwait Kumar on 20/11/24.
//

import SwiftUI

// Enum for combination types
enum ColorCombo: String {
    case autumnBlush
    case goldenBlush
    
    // Pink
    case pink1
    case pink2
    case pink3
    
    case sereneMinimalism
    case vibrant
    case pastel
    case earthy
    case modern
}

// Structure for each combination
struct ColorCombination: Equatable {
    let title: ColorCombo
    let primaryColor: Color
    let secondaryColor: Color
    let borderColor: Color
    let titleColor: Color
    let descriptionColor: Color
    let extraColor: Color
    let primaryGradientCombo: [Color]
    let secondaryGradientCombo: [Color]
    var isSelected: Bool = false // To check if selected
    var isUsedOnce: Bool = false // To keep track if its already used or not
}

class ColorCombinations: ObservableObject {
    
    // Published array of combinations
    @Published var combinations: [ColorCombination] = []
    
    // Singleton instance for global access
    static let shared = ColorCombinations()
    
    private init() {
        loadCombinations()
    }
    
    // Method to load predefined combinations
    private func loadCombinations() {
        combinations = [
            ColorCombination(
                title: .autumnBlush,
                primaryColor: Color(hex: "#f6e3d1"), // Almond Blush
                secondaryColor: Color(hex: "#fbf3eb"), // Soft Linen
                borderColor: Color(hex: "#FDFAED"), // Whisper White
                titleColor: Color(hex: "#CC3333"), // Vermilion Flame
                descriptionColor: Color(hex: "#D2B48C"), // Sandy Beige
                extraColor: Color(hex: "#CC3333"), // Vermilion Flame
                primaryGradientCombo: [Color(hex: "#CC3333"), Color(hex: "#D77A61")], // Vermilion Flame to Coral Glow
                secondaryGradientCombo: [Color(hex: "#D2B48C"), Color(hex: "#FFA07A")] // Sandy Beige to Blush Salmon
            ),
            ColorCombination(
                title: .goldenBlush,
                primaryColor: Color(hex: "#fae8a6"), // Soft Gold
                secondaryColor: Color(hex: "#f8dc75"), // Sunlit Yellow
                borderColor: Color(hex: "#ffae42"), // Golden Orange
                titleColor: Color(hex: "#996300"), // Wooden
                descriptionColor: Color(hex: "#ad9a51"), // Muted Gold
                extraColor: Color(hex: "#e71d36"), // Warm Amber
                primaryGradientCombo: [Color(hex: "#996300"), Color(hex: "#948446")],
                secondaryGradientCombo: [Color(hex: "#948446"), Color(hex: "#ad9a51")]
            )
        ]
    }
    
    // Method to select a combination by its title
    func selectCombination(_ combo: ColorCombo) {
        for index in combinations.indices {
            combinations[index].isSelected = (combinations[index].title == combo)
            combinations[index].isUsedOnce = (combinations[index].title == combo)
        }
    }
    
    // Method to randomly select a combination
    func selectRandomCombination() {
        // Check if there are unused combinations
        if combinations.allSatisfy({ $0.isUsedOnce }) {
            // Reset all combinations to unused if none are left
            for index in combinations.indices {
                combinations[index].isUsedOnce = false
            }
        }

        // Deselect any currently selected combination
        for index in combinations.indices {
            if combinations[index].isSelected {
                combinations[index].isSelected = false
            }
        }

        // Select a random unused combination
        setRandomUnusedCombo()
    }

    private func setRandomUnusedCombo() {
        // Filter unused combinations
        let unusedCombinations = combinations.enumerated().filter { !$0.element.isUsedOnce }
        
        // Ensure there is at least one unused combination (sanity check)
        guard !unusedCombinations.isEmpty else {
            debugPrint("Error: No unused combinations available")
            return
        }

        // Randomly select an unused combination
        let randomIndex = unusedCombinations.randomElement()?.offset ?? 0
        
        // Set the selected combination
        combinations[randomIndex].isSelected = true
        combinations[randomIndex].isUsedOnce = true
    }
    
    // Method to get the currently selected combination
    func selectedCombination() -> ColorCombination? {
        return combinations.first(where: { $0.isSelected })
    }
}

