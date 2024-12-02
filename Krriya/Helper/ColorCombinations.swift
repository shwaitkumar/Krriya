//
//  ColorCombinations.swift
//  Krriya
//
//  Created by Shwait Kumar on 20/11/24.
//

import SwiftUI

// Enum for combination types
enum ColorCombo: String {
    // Light
    case autumnBlush = "Autumn Blush"
    case goldenHorizon = "Golden Horizon"
    case emeraldSerenity = "Emerald Serenity"
    case mutedMonochrome = "Muted Monochrome"
    case lavenderTwilight = "Lavender Twilight"
    // Dark
    case crimsonElegance = "Crimson Elegance"
    case amberShadows = "Amber Shadows"
    // Complementary Light
    case springBlossom = "Spring Blossom"
    case mysticSands = "Mystic Sands"
    // Complementary Dark
    case desertDunes = "Desert Dunes"
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
            // Light
            ColorCombination(
                title: .autumnBlush,
                primaryColor: Color(hex: "#FEF4F2"), // Blush Almond
                secondaryColor: Color(hex: "#FEE8E2"), // Peach Mist
                borderColor: Color(hex: "#F89880"), // Sunset Coral
                titleColor: Color(hex: "#F89880"), // Autumn Flame
                descriptionColor: Color(hex: "#F89880"), // Sunset Glow
                extraColor: Color(hex: "#F89880"), // Autumn Flame
                primaryGradientCombo: [Color(hex: "#F89880"), Color(hex: "#F880A4")], // Sunset Coral to Rose Dawn
                secondaryGradientCombo: [Color(hex: "#F89880"), Color(hex: "#80E0F8")] // Sunset Coral to Sky Glow
            ),
            ColorCombination(
                title: .goldenHorizon,
                primaryColor: Color(hex: "#FDFBDC"), // Morning Glow
                secondaryColor: Color(hex: "#FDFBD4"), // Daffodil Mist
                borderColor: Color(hex: "#D4D6FD"), // Twilight Lilac
                titleColor: Color(hex: "#757575"), // Smoky Bronze
                descriptionColor: Color(hex: "#757575"), // Twilight Gray
                extraColor: Color(hex: "#FBD4FD"), // Lavender Sunset
                primaryGradientCombo: [Color(hex: "#757575"), Color(hex: "#775D6A")], // Smoky Bronze to Antique Mauve
                secondaryGradientCombo: [Color(hex: "#775D6A"), Color(hex: "#F2828E")] // Antique Mauve to Coral Glow
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
            ),
            // Dark
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
            // Complementary Light
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
                title: .mysticSands,
                primaryColor: Color(hex: "#B2BEB5"), // Soft Sage
                secondaryColor: Color(hex: "#BEB2BB"), // Lavender Smoke
                borderColor: Color(hex: "#E8E5DA"), // Whisper Mirage
                titleColor: Color(hex: "#77567A"), // Dusky Rose
                descriptionColor: Color(hex: "#77567A"), // Dusky Rose
                extraColor: Color(hex: "#77567A"), // Dusky Rose Glow
                primaryGradientCombo: [Color(hex: "#77567A"), Color(hex: "#003153")], // Dusky Rose to Deep Sapphire
                secondaryGradientCombo: [Color(hex: "#003153"), Color(hex: "#3A5A40")] // Deep Sapphire to Forest Shade
            ),
            // Complementary Dark
            ColorCombination(
                title: .desertDunes,
                primaryColor: Color(hex: "#253734"), // Evergreen Sand
                secondaryColor: Color(hex: "#372528"), // Smoky Earth
                borderColor: Color(hex: "#EBE9E9"), // Pale Mirage
                titleColor: Color(hex: "#EBE9E9"), // Desert Glow
                descriptionColor: Color(hex: "#F4DECB"), // Sun-Kissed Beige
                extraColor: Color(hex: "#EBE9E9"), // Mirage Gold
                primaryGradientCombo: [Color(hex: "#EBE9E9"), Color(hex: "#F4DECB")], // Desert Glow to Vanilla Cream
                secondaryGradientCombo: [Color(hex: "#E6BE8A"), Color(hex: "#F4DECB")] // Sunlit Gold to Vanilla Cream
            )
        ]
        
        // Test
        //        combinations = [
        //            ColorCombination(
        //                title: .desertDunes,
        //                primaryColor: Color(hex: "#b2beb5"), // Evergreen Sand
        //                secondaryColor: Color(hex: "#beb2bb"), // Smoky Earth
        //                borderColor: Color(hex: "#e8e5da"), // Pale Mirage
        //                titleColor: Color(hex: "#77567a"), // Desert Glow
        //                descriptionColor: Color(hex: "#77567a"), // Sun-Kissed Beige
        //                extraColor: Color(hex: "#77567a"), // Mirage Gold
        //                primaryGradientCombo: [Color(hex: "#77567a"), Color(hex: "#003153")], // Desert Glow to Vanilla Cream
        //                secondaryGradientCombo: [Color(hex: "#003153"), Color(hex: "#3a5a40")] // Sunlit Gold to Vanilla Cream
        //            )
        //        ]
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
    
    // For Swift
    var defaultCombination: ColorCombination {
        combinations[1]
    }
    
    func getCombination(for title: String) -> ColorCombination? {
        combinations.first { $0.title.rawValue == title }
    }
}

