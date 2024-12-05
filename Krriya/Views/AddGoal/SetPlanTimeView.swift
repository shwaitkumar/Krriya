//
//  SetPlanTimeView.swift
//  Krriya
//
//  Created by Shwait Kumar on 03/12/24.
//

import SwiftUI

struct SetPlanTimeView: View {
    @EnvironmentObject var goal: GoalInput

    @State private var selectedTime: Date
    
    let colorCombination: ColorCombination

    init(colorCombination: ColorCombination) {
        self.colorCombination = colorCombination
        _selectedTime = State(initialValue: GoalInput().defaultPlanTime) // Default initialization
    }

    var body: some View {
        ZStack {
            colorCombination.secondaryColor
                .ignoresSafeArea()

            VStack(spacing: 32) {
                // Instructional Text
                Text("Select a time to plan your tasks for tomorrow. It’s not just about organizing—it’s about setting yourself up for success before the day even begins.")
                    .font(.headline)
                    .foregroundStyle(colorCombination.titleColor)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 0) {
                    // DatePicker
                    DatePicker(
                        "",
                        selection: $selectedTime,
                        displayedComponents: [.hourAndMinute]
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .onChange(of: selectedTime, {
                        updateGoalPlanTime(selectedTime)
                    })
                    
                    // Manual Adjustment Buttons
                    HStack {
                        Button(action: {
                            adjustTime(by: -1)
                        }, label: {
                            Image(systemName: "arrowshape.left.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .symbolRenderingMode(.hierarchical)
                                .foregroundStyle(colorCombination.titleColor)
                                .frame(width: 60, height: 60)
                        })
                        .padding(.horizontal)
                        
                        Spacer()
                        
                        Button(action: {
                            adjustTime(by: 1)
                        }, label: {
                            Image(systemName: "arrowshape.right.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .symbolRenderingMode(.hierarchical)
                                .foregroundStyle(colorCombination.titleColor)
                                .frame(width: 60, height: 60)
                        })
                        .padding(.horizontal)
                    } //: HSTACK
                } //: VSTACK
                
                // Selected Time Range
                VStack(spacing: 10) {
                    Text("Selected Time Range")
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundStyle(colorCombination.descriptionColor)
                    
                    formattedTimeRange()
                        .fontWeight(.bold)
                } //: VSTACK
                
                // Motivational Fact
                Text("Studies show that nightly planning improves focus, reduces stress, and boosts productivity by up to 20%. A clear mind at night leads to sharper mornings.")
                    .font(.footnote)
                    .foregroundStyle(colorCombination.titleColor)
                    .multilineTextAlignment(.center)
            } //: VSTACK
            .padding()
        } //: ZSTACK
        .navigationTitle("Set Plan Time")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(colorCombination.isLightTitleColor ? .dark : .light, for: .navigationBar)
        .toolbarBackground(colorCombination.primaryColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear {
            debugPrint("goal title: ", goal.title)
            debugPrint("goal plan time: ", goal.planTime)
            initializeSelectedTime()
        }
    }

    // MARK: - Helper Methods
    private func formattedTimeRange() -> Text {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"

        let start = timeFormatter.string(from: selectedTime)
        let end = timeFormatter.string(from: Calendar.current.date(byAdding: .hour, value: 1, to: selectedTime) ?? selectedTime)
        return Text("\(start)").font(.largeTitle).foregroundStyle(LinearGradient(colors: colorCombination.primaryGradientCombo, startPoint: .topLeading, endPoint: .bottomTrailing)) + Text("  to  ").font(.title).foregroundStyle(LinearGradient(colors: colorCombination.primaryGradientCombo, startPoint: .bottomLeading, endPoint: .topTrailing)) +  Text("\(end)").font(.largeTitle).foregroundStyle(LinearGradient(colors: colorCombination.secondaryGradientCombo, startPoint: .topLeading, endPoint: .bottomTrailing))
    }

    private func initializeSelectedTime() {
        selectedTime = goal.planTime ?? goal.defaultPlanTime
    }

    private func updateGoalPlanTime(_ newTime: Date) {
        goal.planTime = newTime
    }

    private func adjustTime(by minutes: Int) {
        let newTime = Calendar.current.date(byAdding: .minute, value: minutes, to: selectedTime) ?? selectedTime
        selectedTime = newTime
        updateGoalPlanTime(newTime)
    }
}

#Preview {
    SetPlanTimeView(colorCombination: ColorCombinations.shared.defaultCombination)
        .environmentObject(GoalInput())
}
