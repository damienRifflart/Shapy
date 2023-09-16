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
        NavigationView {
            ZStack{
                Color(bgColor)
                    .ignoresSafeArea()
                
                VStack{
                    Text("Hello,")
                        .font(.system(size:50))
                        .foregroundColor(Color.white)
                    + Text("\nDamien").foregroundColor(Color.accentColor)
                        .font(.system(size:50))
                    
                    Spacer()
                    
                    Image("Mockup")
                    
                    Spacer()
                    
                    Button("Start") {
                        selectedTab = 1
                    }
                    .foregroundColor(Color(bgColor))
                    .font(.largeTitle)
                    
                    .padding()
                    
                    // For the bg, it's a rectangle
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.accentColor)
                            .frame(width: 270, height: 55)
                    )
                    
                    Spacer()
                    Spacer()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
