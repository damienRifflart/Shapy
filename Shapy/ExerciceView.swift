//
//  ExerciceView.swift
//  Shapy V1
//
//  Created by Damien Rifflart on 27/08/2023.
//

import SwiftUI

class Var: ObservableObject {
    @Published var currentSerie: Int = 1
    @Published var exerciceOne: String = "First"
    @Published var exerciceTwo: String = "Second"
    @Published var exerciceThree: String = ""
    @Published var exerciceFour: String = ""
    @Published var exerciceIndex: Int = 0
    
}

struct ExerciceView: View {
    @State private var isPausedViewActive = false
    @ObservedObject var variables: Var
    
    var body: some View {
        
        ZStack{
            // Background Color
            Color(hex: 0x0E0215)
                .ignoresSafeArea()
            
            VStack{
                HStack{
                    // Serie Number
                    Text("Série")
                        .foregroundColor(Color(hex: 0xE6D2F7))
                        .font(.system(size: 50))
                        .padding(.leading, 10)
                    
                    Text(String(variables.currentSerie))
                        .foregroundColor(Color.white)
                        .font(.system(size: 50))
                    
                    Spacer()
                    
                    // exercice indicator - if the exercice index is ... than it'll show 1/3
                    if !isPausedViewActive{
                        if [0,3,6,9,12,15,18,21,24, 27,30,33,36,39,42,45,48,51,54,57,60].contains(variables.exerciceIndex){
                            Text("1/3")
                                .foregroundColor(Color.white)
                                .font(.system(size: 50))
                            
                        } else if [1,4,7,10,13,16,19,22,25,
                                   28,31,34,37,40,43,46,49,52,55,58,61].contains(variables.exerciceIndex){
                            Text("2/3")
                                .foregroundColor(Color.white)
                                .font(.system(size: 50))
                            
                        } else if [2,5,8,11,14,17,20,23,26,
                                   29,32,35,38,41,44,47,50,53,56,59,62].contains(variables.exerciceIndex){
                            Text("3/3")
                                .foregroundColor(Color.white)
                                .font(.system(size: 50))
                        }
                    }
                }
                
                Spacer()
                
                // Exercice Name
                if !isPausedViewActive{
                    
                    //
                    
                    // If there's not a second, third nor a fourth
                    if variables.exerciceTwo == "" && variables.exerciceThree == "" && variables.exerciceFour == "" {
                        if [0, 1, 2, 3, 4, 5, 6, 7, 8].contains(variables.exerciceIndex){
                            Text(variables.exerciceOne)
                                .foregroundColor(Color.white)
                                .font(.system(size: 65))
                                .multilineTextAlignment(.center)
                                .frame(width: 250)
                                .padding(.bottom, 30)
                        }
                        
                    // If there's not a third nor a fouth
                    } else if variables.exerciceTwo != "" && variables.exerciceThree == "" && variables.exerciceFour == "" {
                        if [0, 1, 2, 6, 7, 8, 12, 13, 14].contains(variables.exerciceIndex){
                            Text(variables.exerciceOne)
                                .foregroundColor(Color.white)
                                .font(.system(size: 65))
                                .multilineTextAlignment(.center)
                                .frame(width: 250)
                                .padding(.bottom, 30)
                        } else {
                            Text(variables.exerciceTwo)
                                .foregroundColor(Color.white)
                                .font(.system(size: 65))
                                .multilineTextAlignment(.center)
                                .frame(width: 250)
                                .padding(.bottom, 30)
                        }
                        
                    // If there is not a fourth
                    } else if variables.exerciceThree != "" && variables.exerciceFour == "" {
                        
                        if [0, 1, 2, 9, 10, 11, 18, 19, 20].contains(variables.exerciceIndex){
                            Text(variables.exerciceOne)
                                .foregroundColor(Color.white)
                                .font(.system(size: 65))
                                .multilineTextAlignment(.center)
                                .frame(width: 250)
                                .padding(.bottom, 30)
                            
                        } else if [3, 4, 5, 12, 13, 14, 21, 22, 23].contains(variables.exerciceIndex){
                            Text(variables.exerciceTwo)
                                .foregroundColor(Color.white)
                                .font(.system(size: 65))
                                .multilineTextAlignment(.center)
                                .frame(width: 250)
                                .padding(.bottom, 30)
                            
                        } else {
                            Text(variables.exerciceThree)
                                .foregroundColor(Color.white)
                                .font(.system(size: 65))
                                .multilineTextAlignment(.center)
                                .frame(width: 250)
                                .padding(.bottom, 30)
                        }
                        
                    // If there is a fourth
                    } else if variables.exerciceFour != "" {
                        
                        if [0, 1, 2, 12, 13, 14, 24, 25, 26].contains(variables.exerciceIndex){
                            Text(variables.exerciceOne)
                                .foregroundColor(Color.white)
                                .font(.system(size: 65))
                                .multilineTextAlignment(.center)
                                .frame(width: 250)
                                .padding(.bottom, 30)
                            
                        } else if [3, 4, 5, 15, 16, 17, 27, 28, 29].contains(variables.exerciceIndex){
                            Text(variables.exerciceTwo)
                                .foregroundColor(Color.white)
                                .font(.system(size: 65))
                                .multilineTextAlignment(.center)
                                .frame(width: 250)
                                .padding(.bottom, 30)
                            
                        } else if [6, 7, 8, 18, 19, 20, 30, 31, 32].contains(variables.exerciceIndex){
                            Text(variables.exerciceThree)
                                .foregroundColor(Color.white)
                                .font(.system(size: 65))
                                .multilineTextAlignment(.center)
                                .frame(width: 250)
                                .padding(.bottom, 30)
                            
                        } else if [9, 10, 11, 21, 22, 23, 33, 34, 35].contains(variables.exerciceIndex){
                            Text(variables.exerciceFour)
                                .foregroundColor(Color.white)
                                .font(.system(size: 65))
                                .multilineTextAlignment(.center)
                                .frame(width: 250)
                                .padding(.bottom, 30)
                        }
                    }
                    
                    Spacer()
                }
                
                
                // End Button
                Button(action: { isPausedViewActive.toggle(); variables.exerciceIndex += 1
                }) {
                    Text("Finir")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(Color(hex: 0x0E0215))
                        .padding()
                        .frame(width: 300)
                        .background(Color(hex: 0xE6D2F7))
                        .cornerRadius(10)
                }
                .padding(.bottom, 30)
            }
            .fullScreenCover(isPresented: $isPausedViewActive) {
                PausedView(variables: variables)
            }
        }
    }
}



struct ExerciceView_Previews: PreviewProvider {
    static var previews: some View {
        let variables = Var()
        return ExerciceView(variables: variables)
    }
}

