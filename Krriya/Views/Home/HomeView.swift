//
//  HomeView.swift
//  Krriya
//
//  Created by Shwait Kumar on 26/11/24.
//

import SwiftUI

enum TabItem {
    case home
    case goals
}

struct HomeView: View {
    @State private var selectedTab: TabItem = .home
    
    var body: some View {
        ZStack {
            Color.homeBackground
                .ignoresSafeArea(.all)
            
            VStack {
                HStack(spacing: 10) {
                    // Home Button
                    Button(action: {
                        withAnimation(.smooth(duration: 0.3), {
                            selectedTab = .home
                        })
                    }) {
                        Text("Home")
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(height: UITraitCollection.current.horizontalSizeClass == .regular ? 32 : 24, alignment: .center)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(selectedTab == .home ? (UITraitCollection.current.userInterfaceStyle == .dark ? .white.opacity(0.5) : .black.opacity(0.5)) : .clear)
                    .foregroundStyle(selectedTab == .home ? (UITraitCollection.current.userInterfaceStyle == .dark ? .black : .white) : .black)
                    .cornerRadius(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 2)
                    }
                    
                    // Goals Button
                    Button(action: {
                        withAnimation(.smooth(duration: 0.3), {
                            selectedTab = .goals
                        })
                    }) {
                        Text("Goals")
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(height: UITraitCollection.current.horizontalSizeClass == .regular ? 32 : 24, alignment: .center)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(selectedTab == .goals ? (UITraitCollection.current.userInterfaceStyle == .dark ? .white.opacity(0.5) : .black.opacity(0.5)) : .clear)
                    .foregroundStyle(selectedTab == .goals ? (UITraitCollection.current.userInterfaceStyle == .dark ? .black : .white) : .black)
                    .cornerRadius(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 2)
                    }
                    
                    Spacer()
                } //: HSTACK
                .padding([.leading, .top, .bottom])
                
                ZStack {
                    switch selectedTab {
                    case .home:
                        NoGoalView()
                    case .goals:
                        AllGoalEntriesView()
                    }
                } //: ZSTACK
                .ignoresSafeArea(edges: .bottom)
            } //: VSTACK
        } //: ZSTACK
    }
}

#Preview {
    HomeView()
}
