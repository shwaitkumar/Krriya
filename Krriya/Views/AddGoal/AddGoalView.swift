//
//  AddGoalView.swift
//  Krriya
//
//  Created by Shwait Kumar on 02/12/24.
//

import SwiftUI
import SwiftData

struct AddGoalView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var goal: GoalInput
    
    private let colorCombination: ColorCombination = ColorCombinations.shared.defaultCombination
    
    @State private var isNextButtonEnabled: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                colorCombination.secondaryColor
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    VStack {
                        Text("Dream It. Name It. Do It.")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(colorCombination.titleColor)
                        
                        Text("Give your goal a name—it’s the start of something amazing.")
                            .font(.callout)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(colorCombination.descriptionColor)
                    } //: VSTACK
                    
                    TextField("Enter your goal name", text: $goal.title)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(colorCombination.titleColor)
                        .onChange(of: goal.title, {
                            isNextButtonEnabled = !goal.title.isEmpty
                        })
                        .padding()
                } //: VSTACk
            } //: ZSTACK
            .navigationTitle("Set Goal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SetPlanTimeView(colorCombination: colorCombination)
                        .environmentObject(goal)) {
                            Text("Next")
                                .foregroundStyle(isNextButtonEnabled ? Color.black : Color.gray) // Retain custom color
                        }
                        .disabled(!isNextButtonEnabled)
                }
            }
            .toolbarColorScheme(colorCombination.isLightTitleColor ? .dark : .light, for: .navigationBar)
            .toolbarBackground(colorCombination.primaryColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    AddGoalView()
        .environmentObject(GoalInput())
}
