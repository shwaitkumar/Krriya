//
//  ThreeSquaresView.swift
//  Krriya
//
//  Created by Shwait Kumar on 20/11/24.
//

import SwiftUI

import SwiftUI

struct ThreeSquaresView: View {
    var selectedColorCombo: ColorCombination
    var isRightToLeft: Bool = false

    @Binding var isAnimating: Bool

    var body: some View {
        HStack {
            ForEach(0..<3) { index in
                Rectangle()
                    .fill(selectedColorCombo.extraColor)
                    .opacity(isAnimating ? calculateOpacity(for: index) : 0)
                    .frame(width: squareSize, height: squareSize)
                    .scaleEffect(isAnimating ? 1 : 0.5)
                    .rotationEffect(.degrees(isAnimating ? 0 : 360))
                    .offset(x: isAnimating ? 0 : (isRightToLeft ? 50 : -50))
                    .animation(
                        .easeOut(duration: 0.6).delay(Double(index) * 0.2),
                        value: isAnimating
                    )
            }
        } //: HSTACK
        .onAppear {
            withAnimation {
                isAnimating = true
            }
        }
    }

    private var squareSize: CGFloat {
        UITraitCollection.current.horizontalSizeClass == .regular ? 24 : 16
    }

    private func calculateOpacity(for index: Int) -> Double {
        let baseIndex = isRightToLeft ? 2 - index : index
        return 1.0 - (Double(baseIndex) * 0.2)
    }
}

#Preview {
    @Previewable @State var isAnimating: Bool = true
    
    ThreeSquaresView(selectedColorCombo: ColorCombination(
        title: .autumnBlush,
        primaryColor: Color(hex: "#f6e3d1"), // Almond Cream
        secondaryColor: Color(hex: "#fbf3eb"), // Linen White
        borderColor: Color(hex: "#F3E5AB"), // Coral
        titleColor: Color(hex: "#CC3333"), // Vermilion Red
        descriptionColor: Color(hex: "#D2B48C"), // Tan Beige
        extraColor: Color(hex: "#FFFFFF"), // Pure White
        primaryGradientCombo: [Color(hex: "#CC3333"), Color(hex: "#D77A61")], // Vermilion Red to Burnt Coral
        secondaryGradientCombo: [Color(hex: "#D2B48C"), Color(hex: "#FFA07A")] // Tan Beige to Light Salmon
    ), isAnimating: $isAnimating
    )
}
