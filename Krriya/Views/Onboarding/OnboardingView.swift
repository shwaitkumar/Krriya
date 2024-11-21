//
//  OnboardingView.swift
//  Krriya
//
//  Created by Shwait Kumar on 19/11/24.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("isOnboardingComplete") private var isOnboardingComplete: Bool = false
    
    @ObservedObject var colorCombos = ColorCombinations.shared
    
    // State variables for animation
    // Full Screen
    @State private var currentCardContent: OnboardingCardItem? = nil
    // 3 squares
    @State private var isAnimatingLeftToRight: Bool = false
    @State private var isAnimatingRightToLeft: Bool = false
    // Color Combo
    @State private var selectedColorCombo: ColorCombination = ColorCombination(
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
    // Title Text
    @State private var textOffset: CGFloat = 100
    @State private var textOpacity: Double = 0
    // Welcome Card Content (Only for First Card
    @State private var currentContentIndex: Int = 0
    @State private var cardContentOpacity: Double = 0
    @State private var cardContentOffset: CGFloat = 30
    // Button Animations
    @State private var showHowItWorksButton: Bool = false
    
    private let onboardingContent: [OnboardingCardItem] = [
        OnboardingCardItem(id: 1, title: "Welcome to Krriya!", subtitle: "Your journey to self-discipline starts here.", body: "Krriya isn’t just an app—it’s a system to help you transform into a more disciplined and self-reliant person.\nThrough consistent planning, action, and reflection, you’ll create a daily routine that supports growth and progress.", example: nil, quote: nil, fact: nil),
        OnboardingCardItem(id: 2, title: "Start with a Goal", subtitle: nil, body: "Krriya focuses on one goal at a time. This isn’t about challenges or deadlines—it’s about building habits that align with your priorities.\nYour goal is your focus, and it can be as small or as big as you want. Break it into manageable daily tasks to make progress every single day.", example: "Goal: “Become healthier.\nDaily Task: Drink 8 glasses of water, take a 20-minute walk.", quote: "Small steps lead to big changes.", fact: nil)
    ]
    
    private let welcomeScreenContent: [(symbol: String, title: String, text: String)] = [
        ("flag", "Define Your Mission", "Set meaningful goals and map out your vision."),
        ("lightbulb", "Spark Your Ideas", "Channel your creativity into actionable steps."),
        ("pencil.and.outline", "Make It Happen", "Break tasks into manageable pieces and conquer them."),
        ("hourglass", "Stay on Track", "Master your time and make every second count."),
        ("star.circle", "Celebrate Wins", "Acknowledge milestones and build momentum."),
        ("person.circle", "Empower Yourself", "Step into self-reliance—one step at a time.")
    ]
    
    var body: some View {
        ZStack {
            selectedColorCombo.secondaryColor
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    if showHowItWorksButton {
                        Button(action: {
                            withAnimation(.easeInOut, {
                                currentContentIndex = 0
                                cardContentOpacity = 1
                                cardContentOffset = 0
                                showHowItWorksButton.toggle()
                                animateFirstOnboardingCardContent()
                                
                                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                                withAnimation(.easeIn.delay(0.5)) {
                                    isAnimatingLeftToRight.toggle()
                                    isAnimatingRightToLeft.toggle()
                                }
                            })
                        }) {
                            Image(systemName: "arrow.clockwise")
                        }
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxHeight: UITraitCollection.current.horizontalSizeClass == .regular ? 32 : 24, alignment: .center)
                        .padding()
                        .background(selectedColorCombo.primaryColor)
                        .foregroundStyle(selectedColorCombo.titleColor)
                        .opacity(showHowItWorksButton ? 1 : 0)
                        .cornerRadius(10)
                        .animation(.easeIn(duration: 1.0), value: showHowItWorksButton)
                        .animation(.easeInOut(duration: 0.5), value: selectedColorCombo)
                    }
                    else {
                        ThreeSquaresView(selectedColorCombo: selectedColorCombo, isAnimating: $isAnimatingLeftToRight)
                    }
                    
                    Spacer()
                } //: HSTACK
                .frame(height: UITraitCollection.current.horizontalSizeClass == .regular ? 32 : 24)
                .padding()
                
                Text("Welcome to")
                    .font(.title3)
                    .foregroundStyle(selectedColorCombo.titleColor)
                    .offset(y: textOffset)
                    .opacity(textOpacity)
                    .animation(.easeOut(duration: 0.5).delay(0.3), value: textOffset)
                    .animation(.easeOut(duration: 0.5).delay(0.3), value: textOpacity)
                    .animation(.easeInOut(duration: 0.5), value: selectedColorCombo)
                
                Text("Krriya!")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundStyle(selectedColorCombo.titleColor)
                    .offset(y: textOffset)
                    .opacity(textOpacity)
                    .animation(.easeOut(duration: 0.5).delay(0.5), value: textOffset)
                    .animation(.easeOut(duration: 0.5).delay(0.5), value: textOpacity)
                    .animation(.easeInOut(duration: 0.5), value: selectedColorCombo)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(selectedColorCombo.primaryColor)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(selectedColorCombo.borderColor, lineWidth: 4)
                                .overlay {
                                    configureCardOnly()
                                }
                                .animation(.easeInOut(duration: 0.5), value: currentCardContent)
                                .animation(.easeInOut(duration: 0.5), value: selectedColorCombo)
                        }
                } //: ZSTACK
                .padding()
                
                HStack {
                    Spacer()
                    
                    if showHowItWorksButton {
                        Button(action: {
                            let canMoveForward = showNextCard() // If true, mans content has been upgraded to next one otherwise it has returned same content
                            if canMoveForward {
                                showHowItWorksButton.toggle()
                                
                                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    configureFullOnboardingScreen()
                                }
                            }
                        }) {
                            Text("See How it Works")
                            
                            Image(systemName: "chevron.compact.forward")
                        }
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxHeight: UITraitCollection.current.horizontalSizeClass == .regular ? 32 : 24, alignment: .center)
                        .padding()
                        .background(selectedColorCombo.primaryColor)
                        .foregroundStyle(selectedColorCombo.titleColor)
                        .opacity(showHowItWorksButton ? 1 : 0)
                        .cornerRadius(10)
                        .animation(.easeIn(duration: 1.0), value: showHowItWorksButton)
                        .animation(.easeInOut(duration: 0.5), value: selectedColorCombo)
                    }
                    else {
                        ThreeSquaresView(selectedColorCombo: selectedColorCombo, isRightToLeft: true, isAnimating: $isAnimatingRightToLeft)
                    }
                } //: HSTACK
                .frame(height: UITraitCollection.current.horizontalSizeClass == .regular ? 32 : 24)
                .padding()
            } //: VSTACK
            .padding()
            .onAppear {
                withAnimation {
                    currentCardContent = onboardingContent.first
                    configureFullOnboardingScreen()
                }
            }
        } //: ZSTACK
        .interactiveDismissDisabled(true)
    }
    
    private func animateFirstOnboardingCardContent() {
        Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { timer in
            if currentContentIndex < welcomeScreenContent.count - 1 {
                withAnimation {
                    cardContentOpacity = 0
                    cardContentOffset = 30
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    currentContentIndex += 1
                    
                    withAnimation {
                        cardContentOpacity = 1
                        cardContentOffset = 0
                    }
                }
            } else {
                timer.invalidate()
                
                // Show Get Started Button
                withAnimation(.easeOut(duration: 0.5)) {
                    isAnimatingLeftToRight.toggle()
                    isAnimatingRightToLeft.toggle()
                    
                    withAnimation(.easeIn(duration: 0.5).delay(0.5)) {
                        showHowItWorksButton = true
                    }
                }
            }
        }
    }
    
    private func configureFullOnboardingScreen() {
        guard let currentCardContent = currentCardContent else {
            debugPrint("Issue setting onboarding content")
            return
        }
        
        if currentCardContent.id == 1 {
            colorCombos.selectRandomCombination()
            if let selectedCombo = colorCombos.selectedCombination() {
                selectedColorCombo = selectedCombo
            }
            // Trigger animation
            isAnimatingLeftToRight.toggle()
            isAnimatingRightToLeft.toggle()
            textOffset = 0
            textOpacity = 1
            cardContentOpacity = 1
            cardContentOffset = 0
            animateFirstOnboardingCardContent()
        }
        else {
            colorCombos.selectRandomCombination()
            if let selectedCombo = colorCombos.selectedCombination() {
                selectedColorCombo = selectedCombo
            }
        }
    }
    
    private func configureCardOnly() -> some View {
        ZStack {
            if currentCardContent?.id == 1 {
                welcomeCardView()
            }
            else {
                if let currentCardContent = currentCardContent {
                    OnboardingTourCardView(item: currentCardContent, colorCombo: selectedColorCombo)
                }
            }
        }
        //: ZSTACK
        .padding()
        .padding()
        .clipped()
    }
    
    private func welcomeCardView() -> some View {
        VStack {
            Text(currentCardContent?.subtitle ?? "N/A")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(LinearGradient(colors: selectedColorCombo.primaryGradientCombo, startPoint: .leading, endPoint: .trailing))
                .multilineTextAlignment(.center)
                .padding(.vertical)
                .opacity(currentCardContent?.id == 1 ? 1 : 0)
                .animation(.easeIn(duration: 1.0), value: currentCardContent)
            
            Spacer()
            
            HStack {
                Text("\(currentContentIndex + 1)")
                    .foregroundStyle(selectedColorCombo.titleColor)
                    .font(.title)
                    .fontWeight(.black)
                    .frame(width: 30)
                    .offset(y: cardContentOffset)
                    .opacity(cardContentOpacity)
                    .animation(.easeInOut(duration: 0.5), value: cardContentOffset)
                    .animation(.easeInOut(duration: 0.5), value: cardContentOpacity)
                
                Rectangle()
                    .foregroundStyle(selectedColorCombo.titleColor)
                    .frame(width: 4, height: UITraitCollection.current.horizontalSizeClass == .regular ? 90 : 70)
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text(welcomeScreenContent[currentContentIndex].title)
                            .font(.headline)
                            .fontWeight(.heavy)
                            .foregroundStyle(selectedColorCombo.titleColor)
                            .opacity(cardContentOpacity)
                            .offset(y: cardContentOffset)
                            .animation(.easeInOut(duration: 0.5), value: cardContentOpacity)
                            .animation(.easeInOut(duration: 0.5), value: cardContentOffset)
                        
                        
                        Text(welcomeScreenContent[currentContentIndex].text)
                            .font(.footnote)
                            .foregroundStyle(selectedColorCombo.titleColor)
                            .opacity(cardContentOpacity)
                            .offset(y: cardContentOffset)
                            .animation(.easeInOut(duration: 0.5), value: cardContentOpacity)
                            .animation(.easeInOut(duration: 0.5), value: cardContentOffset)
                    } //: VSTACK
                    
                    Spacer()
                    
                    Image(systemName: welcomeScreenContent[currentContentIndex].symbol)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(LinearGradient(colors: selectedColorCombo.primaryGradientCombo, startPoint: .topLeading, endPoint: .bottomTrailing))
                        .symbolEffect(.bounce, value: cardContentOpacity)
                        .symbolEffect(.wiggle.clockwise, value: cardContentOpacity)
                        .frame(width: UITraitCollection.current.horizontalSizeClass == .regular ? 30 : 20, height: UITraitCollection.current.horizontalSizeClass == .regular ? 30 : 20, alignment: .leading)
                } //: HSTACK
            } //: HSTACK
            
            Spacer()
            
            Text(currentCardContent?.body ?? "N/A")
                .font(.callout)
                .italic()
                .foregroundStyle(LinearGradient(colors: selectedColorCombo.primaryGradientCombo, startPoint: .leading, endPoint: .trailing))
                .multilineTextAlignment(.center)
                .padding(.vertical)
                .opacity(currentCardContent?.id == 1 ? 1 : 0)
                .animation(.easeIn(duration: 1.0), value: currentCardContent)
        } //: VSTACK
    }
    
    private func showNextCard() -> Bool {
        guard let currentCardContent = currentCardContent else {
            return false
        }
        
        if let idx = onboardingContent.firstIndex(where: { $0.id == currentCardContent.id }) {
            if idx != onboardingContent.count - 1 {
                self.currentCardContent = onboardingContent[idx + 1]
                return true
            }
            else {
                return false
            }
        }
        
        return false
    }
}

#Preview {
    OnboardingView()
}
