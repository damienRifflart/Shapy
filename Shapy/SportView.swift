//
//  SportView.swift
//  Shapy
//
//  Created by Damien Rifflart on 16/09/2023.
//

import SwiftUI

struct SportView: View {
    
    var bgColor: CGColor
    var accentColor: Color
    @Binding var selectedTab: Int
    
    var body: some View {
        
        NavigationView {
            ZStack{
                Color(bgColor)
                    .ignoresSafeArea()
                
                Text("Sport")
                    .foregroundColor(Color.white)
            }
        }
    }
}

struct SportView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
