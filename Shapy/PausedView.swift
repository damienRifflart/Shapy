//
//  ContentView.swift
//  Shapy
//
//  Created by Damien Rifflart on 26/08/2023.
//

import SwiftUI

let defaultTimeRemaining: CGFloat = 1
let lineWidth: CGFloat = 25
let radius: CGFloat = 110

struct PausedView: View {
    
    @State private var isActive = true
    @State private var timeRemaining: CGFloat = defaultTimeRemaining
    @State private var isExerciceViewActive = false
    @State private var isFinishedViewActive = false
    @ObservedObject var variables: Var
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        ZStack{
            
            // Background Color
            Color(hex: 0x0E0215)
                .ignoresSafeArea()
            
            VStack{
                // Serie Number
                HStack{
                    Text("Série")
                        .foregroundColor(Color(hex: 0xE6D2F7))
                        .font(.system(size: 50))
                        .padding(.leading, 10)
                    
                    Text(String(variables.currentSerie))
                        .foregroundColor(Color.white)
                        .font(.system(size: 50))
                    
                    Spacer()
                    
                    Text("pause")
                        .foregroundColor(Color.white)
                        .font(.system(size: 50))
                    
                }
                Spacer()
                
                // Timer
                VStack(spacing: 25){
                    ZStack{
                        Circle()
                            .stroke(Color.gray.opacity(0.2), style:StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                        
                        Circle()
                            // example: 10 - 7 = 3
                            .trim(from: ((defaultTimeRemaining - timeRemaining)/defaultTimeRemaining), to: 1)
                        
                            // if time remaining > 6 then color is green if it's 3...
                            .stroke(timeRemaining > 0.66 ? Color.green : timeRemaining > 0.33 ? Color.yellow : Color.red, style:StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                        
                            .rotationEffect(.degrees(-90))
                            .animation(.easeInOut, value: timeRemaining)
                        
                        Text("\(Int(timeRemaining))")
                            .font(.system(size:50))
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex: 0xe6d2f7)
    )
                    }
                    .frame(width: radius*2, height: radius*2)
                

                } .onReceive(timer, perform: { _ in guard isActive else { return }
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                        
                    // else: timer is finished
                    } else {
                        isActive = false
                        
                        // if there's enough exercices done to add 1 to serie & if there's no third exercice & no fourth
                        if [6,12,18].contains(variables.exerciceIndex) && variables.exerciceThree == "" && variables.exerciceFour == ""{
                            variables.currentSerie += 1
                            
                        // if there is actually a third exercice but no fourth
                        } else if [9,18,27].contains(variables.exerciceIndex) && variables.exerciceThree != "" && variables.exerciceFour == ""{
                            variables.currentSerie += 1
                           
                        // if there is a fourth exercice
                        } else if [12,24,36].contains(variables.exerciceIndex) && variables.exerciceFour != ""{
                            variables.currentSerie += 1
                            
                        // if there is only one
                        } else if [3,6,9].contains(variables.exerciceIndex) && variables.exerciceTwo == ""{
                            variables.currentSerie += 1
                        }
                        
                        // if there's a fourth exercice
                        if variables.exerciceFour != ""{
                            
                            if
                                [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35]
                                .contains(variables.exerciceIndex){
                                isExerciceViewActive.toggle()
                                
                            } else {
                                isFinishedViewActive.toggle()
                            }
                            
                        // if there's a third exercice
                        } else if variables.exerciceThree != "" && variables.exerciceFour == ""{
                            
                            if
                                [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26]
                                .contains(variables.exerciceIndex){
                                isExerciceViewActive.toggle()
                                
                            } else {
                                isFinishedViewActive.toggle()
                            }
                        
                        // if there's second exercice
                        } else if variables.exerciceTwo != "" && variables.exerciceThree == "" && variables.exerciceFour == ""{
                            
                            if [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17].contains(variables.exerciceIndex){
                                isExerciceViewActive.toggle()
                                
                            } else {
                                isFinishedViewActive.toggle()
                            }
                            
                        // if there's only one
                        } else {
                            if [0,1,2,3,4,5,6,7,8].contains(variables.exerciceIndex){
                                isExerciceViewActive.toggle()
                                
                            } else {
                                isFinishedViewActive.toggle()
                            }
                        }
                    }
                })
                .fullScreenCover(isPresented: $isExerciceViewActive) {
                        ExerciceView(variables: variables)
                    }
                
                .fullScreenCover(isPresented: $isFinishedViewActive) {
                        FinishView()
                    }
                
                Spacer()
                
                // Up Coming Text
                
                // if there is only one exercice
                if variables.exerciceTwo == "" && variables.exerciceThree == "" && variables.exerciceFour == ""{
                    if [0,1,2,3,4,5,6,7,8].contains(variables.exerciceIndex){
                        Text("Après :\n" + variables.exerciceOne)
                            .foregroundColor(Color(hex: 0xE6D2F7))
                            .multilineTextAlignment(.center)
                            .font(.system(size: 55))
                            .padding(.trailing, 45)
                        
                    } else {
                        Text("Après : \nFini")
                            .foregroundColor(Color(hex: 0xE6D2F7))
                            .multilineTextAlignment(.center)
                            .font(.system(size: 55))
                    }
                    
                    // If there is not a second, a third, nor a fourth
                } else if variables.exerciceTwo == "" && variables.exerciceThree == "" && variables.exerciceFour == ""{
                    if [0,1,2,6,7,8,12,13,14].contains(variables.exerciceIndex){
                        Text("Après :\n" + variables.exerciceOne)
                            .foregroundColor(Color(hex: 0xE6D2F7))
                            .multilineTextAlignment(.center)
                            .font(.system(size: 55))
                            .padding(.trailing, 45)
                    
                    } else {
                        Text("Après :\nFini")
                            .foregroundColor(Color(hex: 0xE6D2F7))
                            .multilineTextAlignment(.center)
                            .font(.system(size: 55))
                    }
                    
                // If there is not a third, nor a fourth
                } else if variables.exerciceThree == "" && variables.exerciceFour == ""{
                        if [0,1,2,6,7,8,12,13,14].contains(variables.exerciceIndex){
                            Text("Après :\n" + variables.exerciceOne)
                                .foregroundColor(Color(hex: 0xE6D2F7))
                                .multilineTextAlignment(.center)
                                .font(.system(size: 55))
                                .padding(.trailing, 45)
                            
                        } else if [3,4,5,9,10,11,15,16,17].contains(variables.exerciceIndex){
                            Text("Après :\n" + variables.exerciceTwo)
                                .foregroundColor(Color(hex: 0xE6D2F7))
                                .multilineTextAlignment(.center)
                                .font(.system(size: 55))
                        } else {
                            Text("Après :\nFini")
                                .foregroundColor(Color(hex: 0xE6D2F7))
                                .multilineTextAlignment(.center)
                                .font(.system(size: 55))
                        }
                    
                // If there is not a fourth
                } else if variables.exerciceThree != "" && variables.exerciceFour == ""{
                    if [0,1,2,9,10,11,18,19,20].contains(variables.exerciceIndex){
                        Text("Après :\n" + variables.exerciceOne)
                            .foregroundColor(Color(hex: 0xE6D2F7))
                            .multilineTextAlignment(.center)
                            .font(.system(size: 55))
                            .padding(.trailing, 45)
                        
                    } else if [3,4,5,12,13,14,21,22,23].contains(variables.exerciceIndex){
                        Text("Après :\n" + variables.exerciceTwo)
                            .foregroundColor(Color(hex: 0xE6D2F7))
                            .multilineTextAlignment(.center)
                            .font(.system(size: 55))
                        
                    } else if [6,7,8,15,16,17,24,25,26].contains(variables.exerciceIndex){
                        Text("Après :\n" + variables.exerciceThree)
                            .foregroundColor(Color(hex: 0xE6D2F7))
                            .multilineTextAlignment(.center)
                            .font(.system(size: 55))
                    
                    } else {
                        Text("Après :\nFini")
                            .foregroundColor(Color(hex: 0xE6D2F7))
                            .multilineTextAlignment(.center)
                            .font(.system(size: 55))
                    }
                    
                // If there is a fourth
                } else if variables.exerciceFour != ""{
                    if [0,1,2,12,13,14,24,25,26].contains(variables.exerciceIndex){
                        Text("Après :\n" + variables.exerciceOne)
                            .foregroundColor(Color(hex: 0xE6D2F7))
                            .multilineTextAlignment(.center)
                            .font(.system(size: 55))
                            .padding(.trailing, 45)
                        
                    } else if [3,4,5,15,16,17,27,28,29].contains(variables.exerciceIndex){
                        Text("Après :\n" + variables.exerciceTwo)
                            .foregroundColor(Color(hex: 0xE6D2F7))
                            .multilineTextAlignment(.center)
                            .font(.system(size: 55))
                        
                    } else if [6,7,8,18,19,20,30,31,32].contains(variables.exerciceIndex){
                        Text("Après :\n" + variables.exerciceThree)
                            .foregroundColor(Color(hex: 0xE6D2F7))
                            .multilineTextAlignment(.center)
                            .font(.system(size: 55))
                        
                    } else if [9,10,11,21,22,23,33,34,35].contains(variables.exerciceIndex){
                        Text("Après :\n" + variables.exerciceFour)
                            .foregroundColor(Color(hex: 0xE6D2F7))
                            .multilineTextAlignment(.center)
                            .font(.system(size: 55))
                        
                    } else {
                        Text("Après : \nFini")
                            .foregroundColor(Color(hex: 0xE6D2F7))
                            .multilineTextAlignment(.center)
                            .font(.system(size: 55))
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let variables = Var()
        return PausedView(variables: variables)
    }
}

