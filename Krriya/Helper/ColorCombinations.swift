//
//  ColorCombinations.swift
//  Krriya
//
//  Created by Shwait Kumar on 20/11/24.
//

import SwiftUI

// Enum for combination types
enum ColorCombo: String {
    case autumnBlush = "Autumn Blush"
    case goldenSunset = "Golden Sunset"
    case aquaDream = "Aqua Dream"
    case sandyElegance = "Sandy Elegance"
    case emeraldMist = "Emerald Mist"
    case crimsonElegance = "Crimson Elegance"
    case monochromeCharm = "Monochrome Charm"
    case mutedMonochrome = "Muted Monochrome"
    case lavenderTwilight = "Lavender Twilight"
    case goldenHorizon = "Golden Horizon"
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
                descriptionColor: Color(hex: "#C04657"), // Raspberry Glow
                extraColor: Color(hex: "#CC3333"), // Vermilion Flame
                primaryGradientCombo: [Color(hex: "#C04657"), Color(hex: "#D77A61")], // Raspberry Glow to Coral Glow
                secondaryGradientCombo: [Color(hex: "#C04657"), Color(hex: "#FFA07A")] // Raspberry Glow to Blush Salmon
            ),
            ColorCombination(
                title: .goldenSunset,
                primaryColor: Color(hex: "#fae8a6"), // Sunlit Gold
                secondaryColor: Color(hex: "#f8dc75"), // Golden Glow
                borderColor: Color(hex: "#ffae42"), // Radiant Amber
                titleColor: Color(hex: "#996300"), // Burnished Oak
                descriptionColor: Color(hex: "#ad9a51"), // Golden Olive
                extraColor: Color(hex: "#e71d36"), // Crimson Ember
                primaryGradientCombo: [Color(hex: "#996300"), Color(hex: "#948446")], // Burnished Oak to Antique Brass
                secondaryGradientCombo: [Color(hex: "#948446"), Color(hex: "#ad9a51")] // Antique Brass to Golden Olive
            ),
            ColorCombination(
                title: .aquaDream,
                primaryColor: Color(hex: "#F0FAFB"), // Misty Aqua
                secondaryColor: Color(hex: "#b0e0e6"), // Pastel Wave
                borderColor: Color(hex: "#ffd1dc"), // Petal Pink
                titleColor: Color(hex: "#043927"), // Deep Forest
                descriptionColor: Color(hex: "#007474"), // Oceanic Teal
                extraColor: Color(hex: "#fffacd"), // Lemon Glow
                primaryGradientCombo: [Color(hex: "#043927"), Color(hex: "#007474")], // Deep Forest to Oceanic Teal
                secondaryGradientCombo: [Color(hex: "#5f8a8b"), Color(hex: "#9873ac")] // Steel Blue to Lavender Amethyst
            ),
            ColorCombination(
                title: .sandyElegance,
                primaryColor: Color(hex: "#756A5E"), // Sandy Taupe
                secondaryColor: Color(hex: "#675B5B"), // Smoky Sand
                borderColor: Color(hex: "#F9E79F"), // Dune Gold
                titleColor: Color(hex: "#E6BE8A"), // Desert Sun
                descriptionColor: Color(hex: "#F4DECB"), // Vanilla Cream
                extraColor: Color(hex: "#F9E79F"), // Golden Dusk
                primaryGradientCombo: [Color(hex: "#E6BE8A"), Color(hex: "#F4DECB")], // Desert Sun to Vanilla Cream
                secondaryGradientCombo: [Color(hex: "#E6BE8A"), Color(hex: "#F4DECB")] // Desert Sun to Vanilla Cream
            ),
            ColorCombination(
                title: .emeraldMist,
                primaryColor: Color(hex: "#e1ebe0"), // Frosted Mint
                secondaryColor: Color(hex: "#f2f7f2"), // Icy Glow
                borderColor: Color(hex: "#6e9970"), // Leafy Emerald
                titleColor: Color(hex: "#4d7c51"), // Forest Canopy
                descriptionColor: Color(hex: "#6e9970"), // Sage Whisper
                extraColor: Color(hex: "#4d7c51"), // Forest Canopy
                primaryGradientCombo: [Color(hex: "#4d7c51"), Color(hex: "#6e9970")], // Forest Canopy to Sage Whisper
                secondaryGradientCombo: [Color(hex: "#6e9970"), Color(hex: "#b59fa5")] // Sage Whisper to Rosewood Mist
            ),
            ColorCombination(
                title: .crimsonElegance,
                primaryColor: Color(hex: "#722f37"), // Ruby Shadow
                secondaryColor: Color(hex: "#5e2129"), // Crimson Velvet
                borderColor: Color(hex: "#e3a84f"), // Amber Glint
                titleColor: Color(hex: "#e5d8c8"), // Pearl Cream
                descriptionColor: Color(hex: "#e5d8c8"), // Pearl Cream
                extraColor: Color(hex: "#e5d8c8"), // Pearl Cream
                primaryGradientCombo: [Color(hex: "#e5d8c8"), Color(hex: "#f7e7ce")], // Pearl Cream to Sandstone Glow
                secondaryGradientCombo: [Color(hex: "#e5d8c8"), Color(hex: "#f0f0f0")] // Pearl Cream to Frosted White
            ),
            ColorCombination(
                title: .monochromeCharm,
                primaryColor: Color(hex: "#2d2e2e"), // Charcoal Shadow
                secondaryColor: Color(hex: "#2d2e2e"), // Charcoal Shadow
                borderColor: Color(hex: "#fbfbfb"), // Frosted White
                titleColor: Color(hex: "#bcabae"), // Smoky Rose
                descriptionColor: Color(hex: "#bcabae"), // Smoky Rose
                extraColor: Color(hex: "#bcabae"), // Smoky Rose
                primaryGradientCombo: [Color(hex: "#bcabae"), Color(hex: "#fbfbfb")], // Smoky Rose to Frosted White
                secondaryGradientCombo: [Color(hex: "#bcabae"), Color(hex: "#f6f4ec")] // Smoky Rose to Misty Cloud
            ),
            ColorCombination(
                title: .mutedMonochrome,
                primaryColor: Color(hex: "#F2F0EF"), // Frosted Pearl
                secondaryColor: Color(hex: "#E5E0DC"), // Misty Cloud
                borderColor: Color(hex: "#BFB0A4"), // Sandstone Beige
                titleColor: Color(hex: "#35393A"), // Charcoal Shadow
                descriptionColor: Color(hex: "#777A71"), // Ash Gray
                extraColor: Color(hex: "#777A71"), // Ash Gray
                primaryGradientCombo: [Color(hex: "#35393A"), Color(hex: "#181A19")], // Charcoal Shadow to Deep Ash
                secondaryGradientCombo: [Color(hex: "#35393A"), Color(hex: "#777A71")] // Charcoal Shadow to Ash Gray
            ),
            ColorCombination(
                title: .lavenderTwilight,
                primaryColor: Color(hex: "#b19cd9"), // Lavender Bloom
                secondaryColor: Color(hex: "#b19cd9"), // Lavender Bloom
                borderColor: Color(hex: "#fff9f9"), // Whisper White
                titleColor: Color(hex: "#444054"), // Deep Twilight
                descriptionColor: Color(hex: "#fff9f9"), // Whisper White
                extraColor: Color(hex: "#fff9f9"), // Whisper White
                primaryGradientCombo: [Color(hex: "#4b0082"), Color(hex: "#0000cd")], // Indigo to Royal Blue
                secondaryGradientCombo: [Color(hex: "#444054"), Color(hex: "#4b0082")] // Deep Twilight to Indigo
            ),
            ColorCombination(
                title: .goldenHorizon,
                primaryColor: Color(hex: "#EEB868"), // Sunset Glow
                secondaryColor: Color(hex: "#EEB868"), // Sunset Glow
                borderColor: Color(hex: "#429E9D"), // Teal Breeze
                titleColor: Color(hex: "#565264"), // Slate Gray
                descriptionColor: Color(hex: "#565264"), // Slate Gray
                extraColor: Color(hex: "#429E9D"), // Teal Breeze
                primaryGradientCombo: [Color(hex: "#565264"), Color(hex: "#565264")], // Slate Gray to Deep Slate
                secondaryGradientCombo: [Color(hex: "#565264"), Color(hex: "#000000")] // Slate Gray to Midnight Black
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

