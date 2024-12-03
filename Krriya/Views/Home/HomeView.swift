//
//  HomeView.swift
//  Krriya
//
//  Created by Shwait Kumar on 26/11/24.
//

import SwiftUI
import SwiftData

enum TabItem {
    case home
    case goals
}

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var goals: [Goal]
    
    @State private var selectedTab: TabItem = .home
    @State private var colorCombination: ColorCombination = ColorCombinations.shared.defaultCombination
    
    var body: some View {
        ZStack {
            colorCombination.secondaryColor
                .ignoresSafeArea(.all)
            
            VStack {
                // Tab Selection
                HStack(spacing: 10) {
                    HomeTabButton(selectedTab: $selectedTab, icon: "house", title: "Home", tab: .home, colorCombinaton: colorCombination)
                    HomeTabButton(selectedTab: $selectedTab, icon: "list.bullet.rectangle", title: "Goals", tab: .goals, colorCombinaton: colorCombination)
                    Spacer()
                } //: HSTACK
                .padding([.leading, .top, .bottom])
                
                ZStack {
                    switch selectedTab {
                    case .home:
                        if let currentGoal = goals.first(where: { $0.isCurrent }) {
                            CurrentGoalView(colorCombination: colorCombination)
                        } else {
                            NoGoalView(colorCombination: colorCombination)
                        }
                    case .goals:
                        AllGoalEntriesView(colorCombination: colorCombination)
                    }
                } //: ZSTACK
                .ignoresSafeArea(edges: .bottom)
            } //: VSTACK
            .onAppear {
                updateColorCombination()
            }
            .onChange(of: goals, {
                updateColorCombination()
            })
        } //: ZSTACK
    }
    
    private func updateColorCombination() {
        if let currentGoal = goals.first(where: { $0.isCurrent }) {
            colorCombination = currentGoal.colorCombination
        } else {
            colorCombination = ColorCombinations.shared.defaultCombination
        }
    }
}

struct HomeTabButton: View {
    @Binding var selectedTab: TabItem
    var icon: String
    var title: String
    var tab: TabItem
    let colorCombinaton: ColorCombination
    
    var body: some View {
        Button(action: {
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            withAnimation(.smooth(duration: 0.3)) {
                selectedTab = tab
            }
        }) {
            HStack {
                Image(systemName: selectedTab == tab ? icon + ".fill" : icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .symbolEffect(.wiggle, value: selectedTab)
                
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(height: UITraitCollection.current.horizontalSizeClass == .regular ? 32 : 24, alignment: .center)
            } //: HSTACK
            .background(selectedTab == tab ? colorCombinaton.primaryColor : colorCombinaton.secondaryColor)
            .foregroundStyle(colorCombinaton.titleColor)
            .padding(.horizontal)
            .padding(.horizontal)
            .padding(.vertical, 10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(colorCombinaton.borderColor, lineWidth: selectedTab == tab ? 3 : 2)
            }
        }
    }
}

#Preview {
    HomeView()
}
