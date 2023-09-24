//
//  SportView.swift
//  Shapy
//
//  Created by Damien Rifflart on 16/09/2023.
//

import SwiftUI

struct BreakView: View{
    
    var bgColor: CGColor
    var accentColor: Color
    @Binding var breakViewActive: Bool
    
    @Binding var setIndex: Int
    @Binding var exerciseIndex: Int
    @Binding var breakTime: Int
    
    var body: some View{
        
        ZStack{
            Color(bgColor)
                .ignoresSafeArea()
            
            VStack{
                Text("Set " + String(setIndex+1))
                    .foregroundColor(Color.white)
                    .font(.system(size:30))
                    .padding(.top, 60)
                
                Spacer()
                
                HStack{
                    Text(String(breakTime) + "s")
                        .foregroundColor(Color.white)
                    
                    Text("Break")
                        .foregroundColor(accentColor)
                }
                .font(.system(size:50))
                
                Spacer()
                
                // Timer
                TimerViewBreak(breakViewActive: $breakViewActive, setIndex: $setIndex, exerciseIndex: $exerciseIndex, breakTime: $breakTime)

                
                Spacer()
                
                Text("Hard work beats talent when talent doesn't work hard.\n- Tim Notke")
                    .frame(width: 325)
                    .foregroundColor(Color.white)
                    .font(.system(size:25))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 60)
            }
        }
    }
}

struct SportView: View {
    
    let bgColor: CGColor
    let accentColor: Color
    @Binding var selectedTab: Int
    @State var breakViewActive: Bool = false
    @Binding var setExercises: [[Exercise]]
    @Binding var breakTime: Int

    @State private var setIndex: Int = 0
    @State private var exerciseIndex: Int = 0
    
    
    var body: some View {
        
        ZStack{
            Color(bgColor)
                .ignoresSafeArea()
            
            VStack{
                
                Text("Set " + String(setIndex+1))
                    .foregroundColor(Color.white)
                    .font(.system(size:30))
                    .padding(.top, 60)
                Spacer()
                
                
                // Exercise Text
                VStack{
                    // If the name is "Plank"
                    Text(setExercises[setIndex][exerciseIndex].name == "Plank"
                         // Then put a s for seconds
                         ? String((setExercises[setIndex][exerciseIndex].number)) + "s"
                         // If not don't put one
                         : String((setExercises[setIndex][exerciseIndex].number)))
                    
                        .font(.system(size:50))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                    
                    Text(String(setExercises[setIndex][exerciseIndex].name))
                        .foregroundColor(Color.accentColor)
                        .font(.system(size:50))
                }
                
                if !breakViewActive{
                    if selectedTab == 1{
                        TimerViewSport(setIndex: $setIndex, exerciseIndex: $exerciseIndex, breakViewActive: $breakViewActive, setExercises: setExercises)
                            .padding(.bottom, 60)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    breakViewActive.toggle()
                }){
                    Text("Finish")
                        .font(.system(size: 30))
                        .foregroundColor(Color(bgColor))
                        .padding()
                        .frame(width: 270, height:55)
                        .background(accentColor)
                        .cornerRadius(10)
                        .sheet(isPresented: $breakViewActive, content: {
                            BreakView(bgColor: bgColor, accentColor: accentColor, breakViewActive: $breakViewActive, setIndex: $setIndex, exerciseIndex: $exerciseIndex, breakTime: $breakTime)
                        })
                }
                .padding(.bottom, 81)
                
            }
        }
    }
}

struct SportView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
