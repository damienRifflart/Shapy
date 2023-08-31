//
//  SettingsView.swift
//  Shapy
//
//  Created by Damien Rifflart on 31/08/2023.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var variables: DataManager
    @State private var isLandingViewActive = false
    @State private var exerciceOneInput = ""
    
    func saveButton(){
        isLandingViewActive.toggle()
        variables.exerciceOne = exerciceOneInput
    }
    
    var body: some View {
        
        ZStack{
            // Background Color
            Color(hex: 0x0E0215)
                .ignoresSafeArea()
            

            VStack{
                HStack{
                    // Back Button
                    Button(action: {isLandingViewActive.toggle()
                    }) {
                        Text("Retour")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(Color(hex: 0x0E0215))
                            .padding()
                            .frame(width: 130, height:60)
                            .background(Color(hex: 0xE6D2F7))
                            .cornerRadius(10)
                    }
                    .padding(.leading, 20)
                    
                    Spacer()
                }
                
                Spacer()
                
                TextField("Enter Exercice One Here", text: $exerciceOneInput)
                    .foregroundColor(Color.red)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Spacer()
                
                // Start Button
                Button(action: {saveButton()
                }) {
                    Text("Save")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(Color(hex: 0x0E0215))
                        .padding()
                        .frame(width: 300, height:60)
                        .background(Color(hex: 0xE6D2F7))
                        .cornerRadius(10)
                }
                .padding(.bottom, 20)
            }
            .fullScreenCover(isPresented: $isLandingViewActive) {
                LandingView(variables: variables)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(variables: DataManager())
    }
}
