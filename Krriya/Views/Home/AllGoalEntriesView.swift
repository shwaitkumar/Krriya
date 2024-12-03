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
    AllGoalEntriesView(colorCombination: ColorCombinations.shared.defaultCombination)
}
