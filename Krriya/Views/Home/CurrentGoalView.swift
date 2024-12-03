//
//  CurrentGoalView.swift
//  Krriya
//
//  Created by Shwait Kumar on 27/11/24.
//

import SwiftUI

struct CurrentGoalView: View {
    let colorCombination: ColorCombination
    
    var body: some View {
        ZStack {
            colorCombination.secondaryColor
        } //: ZSTACK
    }
}

#Preview {
    CurrentGoalView(colorCombination: ColorCombinations.shared.defaultCombination)
}
