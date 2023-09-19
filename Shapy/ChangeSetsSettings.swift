//
//  ChangeSetsSettings.swift
//  Shapy
//
//  Created by Damien Rifflart on 17/09/2023.
//

import SwiftUI

struct DisclosureGroupTemplate: View {
    
    let bgColor: CGColor
    let secondColor: CGColor
    let accentColor: Color
    let thirdColor = Color(red: 217/255, green: 217/255, blue: 217/255)
    
    @State private var stepperValue1 = 1
    @State private var stepperValue2 = 1
    @State private var stepperValue3 = 1
    
    var allExercises = ["Pull-Ups", "Push-Ups", "Crunch", "Plank"]
    
    @State private var defaultSelectedExercise1 = "Pull-Ups"
    @State private var defaultSelectedExercise2 = "Pull-Ups"
    @State private var defaultSelectedExercise3 = "Pull-Ups"
    
    var body: some View{
        GroupBox() {
            // First Exercise
            exerciseGroup(stepperValue: $stepperValue1, selectedExercise: $defaultSelectedExercise1)
            
            // Second Exercise
            exerciseGroup(stepperValue: $stepperValue2, selectedExercise: $defaultSelectedExercise2)
            
            // Third Exercise
            exerciseGroup(stepperValue: $stepperValue3, selectedExercise: $defaultSelectedExercise3)
        }
        .groupBoxStyle(CustomColorGroupBox(bgColor: secondColor))
    }
    
    func exerciseGroup(stepperValue: Binding<Int>, selectedExercise: Binding<String>) -> some View {
        Group {
            HStack{
                Spacer()
                
                Stepper(value: stepperValue, in: 1...99, step: 1) {
                    Text("\(stepperValue.wrappedValue)")
                        .foregroundColor(Color(bgColor))
                        .padding(.leading, 10)
                }
                .background(accentColor)
                .cornerRadius(5)
                    
                Spacer()
                Spacer()
                
                Picker("Please choose an exercise", selection: selectedExercise) {
                    ForEach(allExercises, id: \.self) {
                        Text($0)
                    }
                }
                .padding(.trailing, 12)
                .foregroundColor(Color(bgColor))
            }
            .frame(height:50)
        }
        .frame(width:290)
        .cornerRadius(5)
    }
}

// Custom GroupBox Color
struct CustomColorGroupBox: GroupBoxStyle {
    
    let bgColor: CGColor
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .frame(maxWidth: .infinity)
            .padding()
            .background(RoundedRectangle(cornerRadius: 8).fill(Color(bgColor)))
            .overlay(configuration.label.padding(.leading, 4), alignment: .topLeading)
    }
}

struct ChangeSetsSettings: View {
    
    let bgColor: CGColor
    let secondColor: CGColor
    let accentColor: Color

    
    var body: some View {
        ZStack{
            Color(bgColor)
                .ignoresSafeArea()
            
            VStack{
                
                // Set 1
                DisclosureGroup("Set 1") {
                    DisclosureGroupTemplate(bgColor: bgColor, secondColor: secondColor, accentColor: accentColor)
                }
                .foregroundColor(Color.white)
                .frame(width: 300)
                .font(.system(size: 30))
                
    
                // Set 2
                DisclosureGroup("Set 2") {
                    DisclosureGroupTemplate(bgColor: bgColor, secondColor: secondColor, accentColor: accentColor)
                }
                .foregroundColor(Color.white)
                .frame(width: 300)
                .font(.system(size: 30))
                
                // Set 3
                DisclosureGroup("Set 3") {
                    DisclosureGroupTemplate(bgColor: bgColor, secondColor: secondColor, accentColor: accentColor)
                }
                .foregroundColor(Color.white)
                .frame(width: 300)
                .font(.system(size: 30))
                
                Spacer()
                
                // Save Button
                Button(action: {
                    // TODO: Save all data
                }){
                    Text("Save")
                        .font(.system(size: 30))
                        .foregroundColor(Color(bgColor))
                        .padding()
                        .frame(width: 270, height:55)
                        .background(accentColor)
                        .cornerRadius(10)
                }
                .padding(.bottom, 40)
            }
        }
    }
}

struct ChangeSetsSettings_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
