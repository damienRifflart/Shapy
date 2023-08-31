//
//  LandingView.swift
//  Shapy V1
//
//  Created by Damien Rifflart on 27/08/2023.
//

import SwiftUI

extension Color {
    init(hex: Int) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}


struct LandingView: View {
    @State private var isExerciceViewActive = false
    @StateObject private var sharedVariables = Var()

    var body: some View {
        ZStack{
            // Background Color
            Color(hex: 0x0E0215)
                .ignoresSafeArea()
            
            VStack{
                HStack{
                    VStack{
                        // Title Text
                        Text("     Bienvenue")
                            .foregroundColor(Color.white)
                            .font(.system(size: 50))
                            .padding(.top, 110)
                        
                        Text("Damien")
                            .foregroundColor(Color(hex: 0xE6D2F7))
                            .font(.system(size: 50))
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        }
                    .padding(.leading, -25)
                    Spacer()
                    }
                
                Image("mockup")
                    .frame(height: 400)
                
                // Second Page Button
                Button(action: { isExerciceViewActive.toggle()
                }) {
                    Text("Commencer")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(Color(hex: 0x0E0215))
                        .padding()
                        .frame(width: 300)
                        .background(Color(hex: 0xE6D2F7))
                        .cornerRadius(10)
                        .padding(.bottom, 130)
                }

            }
            .fullScreenCover(isPresented: $isExerciceViewActive) {
                ExerciceView(variables: sharedVariables)
            }
        }
    }
}


struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
