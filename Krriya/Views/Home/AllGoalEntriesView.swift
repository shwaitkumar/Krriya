//
//  AllGoalEntriesView.swift
//  Krriya
//
//  Created by Shwait Kumar on 27/11/24.
//

import SwiftUI

struct AllGoalEntriesView: View {
    let colorCombination: ColorCombination
    
    var body: some View {
        ZStack {
            colorCombination.secondaryColor
        } //: ZSTACK
    }
}

#Preview {
    AllGoalEntriesView(colorCombination: ColorCombination(
        title: .autumnBlush,
        primaryColor: Color(hex: "#FEF4F2"), // Blush Almond
        secondaryColor: Color(hex: "#FEE8E2"), // Peach Mist
        borderColor: Color(hex: "#F89880"), // Sunset Coral
        titleColor: Color(hex: "#F89880"), // Autumn Flame
        descriptionColor: Color(hex: "#F89880"), // Sunset Glow
        extraColor: Color(hex: "#F89880"), // Autumn Flame
        primaryGradientCombo: [Color(hex: "#F89880"), Color(hex: "#F880A4")], // Sunset Coral to Rose Dawn
        secondaryGradientCombo: [Color(hex: "#F89880"), Color(hex: "#80E0F8")] // Sunset Coral to Sky Glow
    ))
}
