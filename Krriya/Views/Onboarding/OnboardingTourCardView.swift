//
//  OnboardingTourCardView.swift
//  Krriya
//
//  Created by Shwait Kumar on 21/11/24.
//

import SwiftUI

struct OnboardingTourCardView: View {
    var item: OnboardingCardItem
    var colorCombo: ColorCombination
    
    var body: some View {
        VStack {
            Text(item.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(colorCombo.titleColor)
                .multilineTextAlignment(.center)
            
            ZStack {
                Color(colorCombo.titleColor)
            } //: ZSTACK
            .frame(height: 3)
            
            VStack {
                if let body = item.body {
                    Text(body)
                        .font(.body)
                        .foregroundStyle(colorCombo.descriptionColor)
                        .multilineTextAlignment(.center)
                }
                
                if let example = item.example {
                    Text(example)
                        .font(.footnote)
                        .foregroundStyle(LinearGradient(colors: colorCombo.primaryGradientCombo, startPoint: .leading, endPoint: .trailing))
                        .multilineTextAlignment(.leading)
                        .padding(.top)
                }
                
                if let quote = item.quote {
                    Text(quote)
                        .font(.callout)
                        .italic()
                        .foregroundStyle(LinearGradient(colors: colorCombo.secondaryGradientCombo, startPoint: .leading, endPoint: .trailing))
                        .multilineTextAlignment(.center)
                        .padding(.top)
                }
                
                if let fact = item.fact {
                    Text(fact)
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundStyle(colorCombo.titleColor)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                }
            } //: VSTACK
        } //: VSTACK
    }
}

#Preview {
    OnboardingTourCardView(item: OnboardingCardItem(id: 2, title: "Start with a Goal", subtitle: nil, body: "Krriya focuses on one goal at a time. This isn’t about challenges or deadlines—it’s about building habits that align with your priorities.\nYour goal is your focus, and it can be as small or as big as you want. Break it into manageable daily tasks to make progress every single day.", example: "Goal: “Become healthier.\nDaily Task: Drink 8 glasses of water, take a 20-minute walk.", quote: "Small steps lead to big changes.", fact: nil), colorCombo: ColorCombination(
        title: .autumnBlush,
        primaryColor: Color(hex: "#f6e3d1"), // Almond Blush
        secondaryColor: Color(hex: "#fbf3eb"), // Soft Linen
        borderColor: Color(hex: "#FDFAED"), // Whisper White
        titleColor: Color(hex: "#CC3333"), // Vermilion Flame
        descriptionColor: Color(hex: "#D2B48C"), // Sandy Beige
        extraColor: Color(hex: "#CC3333"), // Vermilion Flame
        primaryGradientCombo: [Color(hex: "#CC3333"), Color(hex: "#D77A61")], // Vermilion Flame to Coral Glow
        secondaryGradientCombo: [Color(hex: "#D2B48C"), Color(hex: "#FFA07A")] // Sandy Beige to Blush Salmon
    )
)
}
