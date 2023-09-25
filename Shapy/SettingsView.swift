//
//  SettingsView.swift
//  Shapy
//
//  Created by Damien Rifflart on 16/09/2023.
//

import SwiftUI

struct SettingsView: View {
    
    let bgColor: CGColor
    let secondColor: CGColor
    let accentColor: Color
    @Binding var selectedTab: Int
    @Binding var setExercises: [[Exercise]]
    
    @Binding var setIndex: Int
    @Binding var exerciseIndex: Int
    @Binding var breakTime: Int
    
    var body: some View {
        
        NavigationView{
            ZStack{
                Color(bgColor)
                    .ignoresSafeArea()
                
                    
                VStack{
                    
                    // First Button
                    Button(action: {
                        
                    }) {
                        NavigationLink(destination: ChangeSetsSettings(bgColor: bgColor, secondColor: secondColor, accentColor: accentColor, setExercises: $setExercises, breakTime: breakTime)) {
                            
                            HStack{
                                Spacer()
                                
                                Text("Change sets")
                                    .font(.system(size: 27))
                                    .foregroundColor(Color.white)
                                
                                Spacer()
                                
                                Image(systemName: "arrow.forward.circle.fill")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 27))
                                    .padding(.trailing, 20)
                                    .padding(.leading, 65)
                            }
                            .frame(width: 290, height: 55)
                            .background(Color(secondColor))
                            .cornerRadius(10)
                            .padding(.top, 40)
                        }
                    }
                    .padding(.bottom, 20)
                    
                    // Break time entry
                    HStack{
                        Text("Break time")
                            .font(.system(size:24))
                            .foregroundColor(Color.white)
                            .padding(.leading, 12)
                        
                        Spacer()
                        
                        Stepper(value: $breakTime, in: 1...60, step: 1) {
                            Text("\($breakTime.wrappedValue)")
                                .font(.system(size: 23))
                                .foregroundColor(Color(bgColor))
                                .padding(.leading, 9)

                        }
                        .frame(width: 140)
                        .background(accentColor)
                        .cornerRadius(5)
                        .padding(.trailing, 10)
                    }
                    .frame(width: 290, height: 55)
                    .background(Color(secondColor))
                    .cornerRadius(10)

                    Spacer()
                    
                    Button(action: {
                        for setIndex in 0..<setExercises.count {
                            for exerciseIndex in 0..<setExercises[setIndex].count {
                                setExercises[setIndex][exerciseIndex].name = "Push-Ups"
                                setExercises[setIndex][exerciseIndex].number = 1
                            }
                        }
                            
                        breakTime = 1
                        
                        // Save the data to UserDefaults
                        let encoder = JSONEncoder()
                        if let encodedData = try? encoder.encode(setExercises) {
                            UserDefaults.standard.set(encodedData, forKey: "exercisesKey")
                        }
                        
                        UserDefaults.standard.set(breakTime, forKey: "breakTimeKey")


                    }){
                        Text("Reset Data")
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
        .navigationTitle("Settings")


    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
