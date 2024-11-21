//
//  KrriyaApp.swift
//  Krriya
//
//  Created by Shwait Kumar on 19/11/24.
//

import SwiftUI

@main
struct KrriyaApp: App {
    @AppStorage("isOnboardingComplete") private var isOnboardingComplete: Bool = false
    @State private var isPresented: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    print("Onboarding Status: ", isOnboardingComplete ? "Complete" : "Incomplete")
                    if !isOnboardingComplete {
                        isPresented = true
                    }
                }
                .sheet(isPresented: $isPresented, content: {
                    OnboardingView()
                        .presentationDetents([.fraction(6)])
                        .presentationCornerRadius(24)
                })
        }
    }
}
