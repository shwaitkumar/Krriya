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
    
    ThreeSquaresView(selectedColorCombo:  ColorCombination(
        title: .springBlossom,
        primaryColor: Color(hex: "#F0F8FF"), // Alice Blue
        secondaryColor: Color(hex: "#F8FFF0"), // Mint Frost
        borderColor: Color(hex: "#FFF0F8"), // Blush Pearl
        titleColor: Color(hex: "#F19CBB"), // Rose Petal Pink
        descriptionColor: Color(hex: "#9966CC"), // Amethyst Glow
        extraColor: Color(hex: "#F19CBB"), // Rose Petal Pink
        primaryGradientCombo: [Color(hex: "#9966CC"), Color(hex: "#F19CBB")], // Amethyst Glow to Rose Petal Pink
        secondaryGradientCombo: [Color(hex: "#9966CC"), Color(hex: "#50C878")] // Amethyst Glow to Emerald Mist
    ), isAnimating: $isAnimating
    )
}
