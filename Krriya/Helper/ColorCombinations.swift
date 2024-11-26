//
//  ColorCombinations.swift
//  Krriya
//
//  Created by Shwait Kumar on 20/11/24.
//

import SwiftUI

// Enum for combination types
enum ColorCombo: String {
    case springBlossom = "Spring Blossom"
    case autumnBlush = "Autumn Blush"
    case goldenHorizon = "Golden Horizon"
    case desertDunes = "Desert Dunes"
    case emeraldSerenity = "Emerald Serenity"
    case crimsonElegance = "Crimson Elegance"
    case amberShadows = "Amber Shadows"
    case mutedMonochrome = "Muted Monochrome"
    case lavenderTwilight = "Lavender Twilight"
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
                title: .springBlossom,
                primaryColor: Color(hex: "#F0F8FF"), // Alice Blue
                secondaryColor: Color(hex: "#FFF7F0"), // Blush Frost
                borderColor: Color(hex: "#FFF0F8"), // Petal Whisper
                titleColor: Color(hex: "#F19CBB"), // Rose Petal Pink
                descriptionColor: Color(hex: "#9966CC"), // Amethyst Bloom
                extraColor: Color(hex: "#F19CBB"), // Rose Petal Pink
                primaryGradientCombo: [Color(hex: "#9966CC"), Color(hex: "#F19CBB")], // Amethyst Bloom to Rose Petal Pink
                secondaryGradientCombo: [Color(hex: "#9966CC"), Color(hex: "#50C878")] // Amethyst Bloom to Spring Emerald
            ),
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
                title: .goldenHorizon,
                primaryColor: Color(hex: "#FFED85"), // Sunlit Gold
                secondaryColor: Color(hex: "#F8DC75"), // Daffodil Glow
                borderColor: Color(hex: "#FFAE42"), // Amber Radiance
                titleColor: Color(hex: "#996300"), // Burnished Bronze
                descriptionColor: Color(hex: "#AD9A51"), // Olive Sheen
                extraColor: Color(hex: "#FF7C35"), // Sunset Ember
                primaryGradientCombo: [Color(hex: "#996300"), Color(hex: "#948446")], // Burnished Bronze to Antique Brass
                secondaryGradientCombo: [Color(hex: "#948446"), Color(hex: "#AD9A51")] // Antique Brass to Olive Sheen
            ),
            ColorCombination(
                title: .desertDunes,
                primaryColor: Color(hex: "#726259"), // Driftwood Taupe
                secondaryColor: Color(hex: "#635147"), // Smoky Sand
                borderColor: Color(hex: "#D2B48C"), // Dune Gold
                titleColor: Color(hex: "#D2B48C"), // Desert Glow
                descriptionColor: Color(hex: "#F4DECB"), // Vanilla Cream
                extraColor: Color(hex: "#D2B48C"), // Sunset Gold
                primaryGradientCombo: [Color(hex: "#E6BE8A"), Color(hex: "#F4DECB")], // Desert Glow to Vanilla Cream
                secondaryGradientCombo: [Color(hex: "#E6BE8A"), Color(hex: "#F4DECB")] // Desert Glow to Vanilla Cream
            ),
            ColorCombination(
                title: .emeraldSerenity,
                primaryColor: Color(hex: "#BCD2BB"), // Frosted Mint
                secondaryColor: Color(hex: "#B5CEB4"), // Icy Glow
                borderColor: Color(hex: "#E4E3C1"), // Leafy Gold
                titleColor: Color(hex: "#4A745E"), // Forest Canopy
                descriptionColor: Color(hex: "#6E9970"), // Sage Whisper
                extraColor: Color(hex: "#E4E3C1"), // Leafy Gold
                primaryGradientCombo: [Color(hex: "#4A745E"), Color(hex: "#6E9970")], // Forest Canopy to Sage Whisper
                secondaryGradientCombo: [Color(hex: "#4A745E"), Color(hex: "#B5A6D1")] // Forest Canopy to Rosewood Mist
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
                title: .amberShadows,
                primaryColor: Color(hex: "#24272F"), // Midnight Charcoal
                secondaryColor: Color(hex: "#282C35"), // Deep Obsidian
                borderColor: Color(hex: "#DEE2EB"), // Misty Cloud
                titleColor: Color(hex: "#E1B570"), // Amber Glow
                descriptionColor: Color(hex: "#E1B570"), // Amber Glow
                extraColor: Color(hex: "#E1B570"), // Amber Glow
                primaryGradientCombo: [Color(hex: "#E1B570"), Color(hex: "#E7A39A")], // Amber Glow to Sunset Rose
                secondaryGradientCombo: [Color(hex: "#E1B570"), Color(hex: "#DEE2EB")] // Amber Glow to Misty Cloud
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
                primaryColor: Color(hex: "#C0AFE0"), // Lavender Bloom
                secondaryColor: Color(hex: "#B19CD9"), // Soft Lilac
                borderColor: Color(hex: "#FFF9F9"), // Whisper White
                titleColor: Color(hex: "#444054"), // Deep Twilight
                descriptionColor: Color(hex: "#7851A9"), // Violet Elegance
                extraColor: Color(hex: "#FFF9F9"), // Misty White
                primaryGradientCombo: [Color(hex: "#444054"), Color(hex: "#7851A9")], // Deep Twilight to Violet Elegance
                secondaryGradientCombo: [Color(hex: "#4B0082"), Color(hex: "#9400D3")] // Indigo Glow to Royal Amethyst
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

