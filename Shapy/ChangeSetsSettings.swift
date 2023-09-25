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

    @Binding var setExercises: [Exercise]

    var allExercises = ["Pull-Ups", "Push-Ups", "Crunch", "Plank", "None"]

    var body: some View {
        GroupBox() {

            ForEach(setExercises.indices, id: \.self) { index in
                exerciseGroup(stepperValue: $setExercises[index].number, selectedExercise: $setExercises[index].name)
            }
            
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
    @Binding var setExercises: [[Exercise]]
    var breakTime: Int
    
    var body: some View {
        ZStack{
            Color(bgColor)
                .ignoresSafeArea()
            
            ScrollView {
                VStack{
                    
                    // Set 1
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(bgColor))
                        DisclosureGroup("Set 1") {
                            DisclosureGroupTemplate(bgColor: bgColor, secondColor: secondColor, accentColor: accentColor, setExercises: $setExercises[0])
                        }
                        .foregroundColor(Color.white)
                        .frame(width: 300)
                        .font(.system(size: 30))
                    }
                    
                    // Set 2
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(bgColor))
                        DisclosureGroup("Set 2") {
                            DisclosureGroupTemplate(bgColor: bgColor, secondColor: secondColor, accentColor: accentColor, setExercises: $setExercises[1])
                        }
                        .foregroundColor(Color.white)
                        .frame(width: 300)
                        .font(.system(size: 30))
                    }
                    
                    // Set 3
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(bgColor))
                        DisclosureGroup("Set 3") {
                            DisclosureGroupTemplate(bgColor: bgColor, secondColor: secondColor, accentColor: accentColor, setExercises: $setExercises[2])
                        }
                        .foregroundColor(Color.white)
                        .frame(width: 300)
                        .font(.system(size: 30))
                    }
                    
                    Spacer()
                }
            }
        }
        
        .onDisappear {
            saveData()
        }
    }
    
    func saveData() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(setExercises) {
            UserDefaults.standard.set(encodedData, forKey: "exercisesKey")
        }
        
        UserDefaults.standard.set(breakTime, forKey: "breakTimeKey")
    }
}

struct ChangeSetsSettings_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
