//
//  SetPlanTimeView.swift
//  Krriya
//
//  Created by Shwait Kumar on 03/12/24.
//

import SwiftUI

struct SetPlanTimeView: View {
    @EnvironmentObject var goal: GoalInput

    @State private var selectedTime: Date = Date()
    
    let colorCombination: ColorCombination

    var body: some View {
        ZStack {
            colorCombination.secondaryColor
                .ignoresSafeArea()

            VStack(spacing: 32) {
                Text("Plan Time: \(formattedTimeRange())")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(colorCombination.titleColor)

                HStack {
                    Button("⬅︎") {
                        selectedTime = Calendar.current.date(byAdding: .minute, value: -1, to: selectedTime) ?? selectedTime
                    }
                    .font(.largeTitle)
                    .foregroundStyle(colorCombination.titleColor)

                    Spacer()

                    DatePicker(
                        "",
                        selection: $selectedTime,
                        displayedComponents: [.hourAndMinute]
                    )
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .onChange(of: selectedTime) { newTime in
                        goal.planTime = newTime
                    }

                    Spacer()

                    Button("➡︎") {
                        selectedTime = Calendar.current.date(byAdding: .minute, value: 1, to: selectedTime) ?? selectedTime
                    }
                    .font(.largeTitle)
                    .foregroundStyle(colorCombination.titleColor)
                }
                .frame(height: 200)
            } //: VSTACK
            .padding()
        } //: ZSTACK
        .navigationTitle("Set Plan Time")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(colorCombination.isLightTitleColor ? .dark : .light, for: .navigationBar)
        .toolbarBackground(colorCombination.primaryColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear {
            debugPrint("Goal Input Data: - ", goal.title)
            // Initialize selectedTime with goal's planTime or defaultPlanTime
            selectedTime = goal.planTime ?? goal.defaultPlanTime
        }
    }

    private func formattedTimeRange() -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"

        let start = timeFormatter.string(from: selectedTime)
        let end = timeFormatter.string(from: Calendar.current.date(byAdding: .hour, value: 1, to: selectedTime) ?? selectedTime)
        return "\(start) - \(end)"
    }
}

#Preview {
    SetPlanTimeView(colorCombination: ColorCombinations.shared.defaultCombination)
        .environmentObject(GoalInput())
}
