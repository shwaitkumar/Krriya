//
//  OnboardingTourCardView.swift
//  Krriya
//
//  Created by Shwait Kumar on 21/11/24.
//

import SwiftUI

struct OnboardingTourCardView: View {
    @Binding var isNextStepAvailable: Bool
    
    // Animation States
    @State private var titleOpacity: Double = 0
    @State private var isBarScaledUp: Bool = false
    @State private var isContentHidden: Bool = true
    @State private var bodyOpacity: Double = 0
    @State private var exampleOpacity: Double = 0
    @State private var quoteOpacity: Double = 0
    @State private var factOpacity: Double = 0
    @State private var currentItem: OnboardingCardItem? // Holds the current visible content
    
    var item: OnboardingCardItem
    var colorCombo: ColorCombination
    
    var body: some View {
        VStack {
            // Title
            Text(currentItem?.title ?? "")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(colorCombo.titleColor)
                .multilineTextAlignment(.center)
                .opacity(titleOpacity)
            
            // Bar Below Title
            ZStack {
                Color(colorCombo.titleColor)
            } //: ZSTACK
            .frame(height: 3)
            .scaleEffect(isBarScaledUp ? 1 : 0, anchor: .center)
            .animation(.easeInOut(duration: 0.5), value: isBarScaledUp)
            
            // Content
            if !isContentHidden {
                ScrollView(.vertical) {
                    VStack {
                        if let body = currentItem?.body {
                            Text(body)
                                .font(.body)
                                .foregroundStyle(colorCombo.descriptionColor)
                                .multilineTextAlignment(.center)
                                .opacity(bodyOpacity)
                        }
                        
                        if let example = currentItem?.example {
                            Text("Example")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundStyle(LinearGradient(colors: colorCombo.primaryGradientCombo, startPoint: .leading, endPoint: .trailing))
                                .multilineTextAlignment(.leading)
                                .padding(.top)
                                .opacity(exampleOpacity)
                            
                            Text(example)
                                .font(.footnote)
                                .foregroundStyle(LinearGradient(colors: colorCombo.primaryGradientCombo, startPoint: .leading, endPoint: .trailing))
                                .multilineTextAlignment(.leading)
                                .opacity(exampleOpacity)
                        }
                        
                        if let quote = currentItem?.quote {
                            Text(quote)
                                .font(.callout)
                                .italic()
                                .foregroundStyle(LinearGradient(colors: colorCombo.secondaryGradientCombo, startPoint: .leading, endPoint: .trailing))
                                .multilineTextAlignment(.center)
                                .padding(.top)
                                .opacity(quoteOpacity)
                        }
                        
                        if let fact = currentItem?.fact {
                            Text(fact)
                                .font(.callout)
                                .fontWeight(.bold)
                                .foregroundStyle(colorCombo.titleColor)
                                .multilineTextAlignment(.center)
                                .padding(.top)
                                .opacity(factOpacity)
                        }
                    } //: VSTACK
                    .animation(.easeInOut(duration: 0.3), value: isContentHidden)
                }
                .scrollIndicators(.hidden)
            }
        } //: VSTACK
        .onAppear {
            currentItem = item // Initialize the current content
            animateCardContent()
        }
        .onChange(of: item, {
            resetAnimations {
                currentItem = item // Update content after reset animation
                animateCardContent()
            }
        })
    }
    
    private func animateCardContent() {
        // Title Animation
        withAnimation(.easeInOut(duration: 0.5)) {
            titleOpacity = 1
        }
        
        // Bar Expansion Animation
        withAnimation(.easeInOut(duration: 0.5).delay(0.3)) {
            isBarScaledUp.toggle()
        }
        
        // Content Animation
        withAnimation(.easeInOut(duration: 0.4).delay(0.4)) {
            isContentHidden.toggle()
            bodyOpacity = 1
        }
        
        withAnimation(.easeInOut(duration: 0.4).delay(0.6)) {
            exampleOpacity = 1
        }
        
        withAnimation(.easeInOut(duration: 0.4).delay(0.8)) {
            quoteOpacity = 1
        }
        
        withAnimation(.easeInOut(duration: 0.4).delay(1.0)) {
            factOpacity = 1
        }
        
        // Indicate animation completion
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isNextStepAvailable.toggle()
        }
    }
    
    private func resetAnimations(completion: @escaping () -> Void) {
        // Collapse content and fade title simultaneously
        withAnimation(.easeInOut(duration: 0.4)) {
            factOpacity = 0
            quoteOpacity = 0
            exampleOpacity = 0
            bodyOpacity = 0
            titleOpacity = 0
            isContentHidden.toggle()
        }
        
        // Shrink Bar Animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation(.easeInOut(duration: 0.3)) {
                isBarScaledUp.toggle()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                completion()
            }
        }
    }
}

#Preview {
    @Previewable @State var isNextStepAvailable: Bool = false
    
    OnboardingTourCardView(isNextStepAvailable: $isNextStepAvailable, item: OnboardingCardItem(id: 2, title: "Start with a Goal", subtitle: nil, body: "Krriya focuses on one goal at a time. This isn’t about challenges or deadlines—it’s about building habits that align with your priorities.\nYour goal is your focus, and it can be as small or as big as you want. Break it into manageable daily tasks to make progress every single day.", example: "Goal: “Become healthier.\nDaily Task: Drink 8 glasses of water, take a 20-minute walk.", quote: "Small steps lead to big changes.", fact: nil), colorCombo: ColorCombination(
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
