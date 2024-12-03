//
//  NoGoalView.swift
//  Krriya
//
//  Created by Shwait Kumar on 27/11/24.
//

import SwiftUI

struct NoGoalView: View {
    @State private var isPresented: Bool = false
    
    let colorCombination: ColorCombination
    
    var body: some View {
        ZStack {
            colorCombination.secondaryColor
            
            VStack(spacing: 20) {
                Image("noContentClock")
                    .resizable()
                    .scaledToFit()
                
                VStack {
                    Text("No Goal")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(colorCombination.titleColor)
                    
                    Text("Start your journey today. Create a goal and take the first step towards becoming your best self.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(colorCombination.descriptionColor)
                        .padding(.horizontal)
                } //: VSTACK
                
                Button(action: {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    withAnimation {
                        isPresented.toggle()
                    }
                }) {
                    ZStack {
                        HStack {
                            Image(systemName: "plus")
                                .padding([.leading, .vertical])
                            
                            Text("Create Goal")
                                .padding([.vertical, .trailing])
                        } //: HSTACK
                        .foregroundStyle(LinearGradient(colors: colorCombination.primaryGradientCombo, startPoint: .topLeading, endPoint: .bottomTrailing))
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    } //:ZSTACK
                    .padding(.horizontal)
                }
                .background(
                    Color.white
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding()
                .sheet(isPresented: $isPresented, content: {
                    AddGoalView()
                        .presentationDetents([.fraction(6)])
                        .presentationCornerRadius(24)
                        .environmentObject(GoalInput())
                })
                
                Spacer()
            } //: VSTACK
        } //: ZSTACK
    }
}

#Preview {
    NoGoalView(colorCombination: ColorCombinations.shared.defaultCombination)
}
