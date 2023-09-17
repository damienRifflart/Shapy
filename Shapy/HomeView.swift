//
//  HomeView.swift
//  Shapy
//
//  Created by Damien Rifflart on 16/09/2023.
//

import SwiftUI

struct HomeView: View {
    
    var bgColor: CGColor
    var accentColor: Color
    @Binding var selectedTab: Int
    
    var body: some View {
        
        ZStack{
            Color(bgColor)
                .ignoresSafeArea()
            
            VStack{
                Text("Hello,")
                    .font(.system(size:50))
                    .foregroundColor(Color.white)
                    .padding(.top, 60)
                
                Text("Damien")
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
                .padding(.bottom, 60)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
