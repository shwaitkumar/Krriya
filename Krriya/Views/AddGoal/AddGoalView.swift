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
    
    @State private var name: String = ""
    
    var body: some View {
        VStack(spacing: 24) {
            VStack {
                Text("Dream It. Name It. Do It.")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("Give your goal a name—it’s the start of something amazing.")
                    .font(.callout)
                    .multilineTextAlignment(.center)
            } //: VSTACK
            
            TextField("Enter your goal name", text: $name)
                .multilineTextAlignment(.center)
        } //: VSTACK
    }
}

#Preview {
    AddGoalView()
}
