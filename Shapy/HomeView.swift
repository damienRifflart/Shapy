//
//  HomeView.swift
//  Shapy
//
//  Created by Damien Rifflart on 16/09/2023.
//

import SwiftUI

struct HomeView: View {
    
    let bgColor: CGColor
    let accentColor: Color
    @Binding var selectedTab: Int
    
    var breakTime: Int
    var setExercises: [[Exercise]]
    
    var body: some View {
        
        ZStack{
            Color(bgColor)
                .ignoresSafeArea()
            
            VStack{
                Text("Hello,")
                    .font(.system(size:50))
                    .foregroundColor(Color.white)
                    .padding(.top, 60)
                
                Text("Dams")
                    .font(.system(size:50))
                    .foregroundColor(Color.accentColor)
                
                Spacer()
                
                Image("Mockup")
                
                Spacer()
                
                Button(action: {
                    selectedTab = 1
                }){
                    Text("Start")
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
        .onAppear(){
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
