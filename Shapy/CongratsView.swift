//
//  CongratsView.swift
//  Shapy
//
//  Created by Damien Rifflart on 24/09/2023.
//

import SwiftUI

struct CongratsView: View {
    
    let bgColor: CGColor
    let accentColor: Color
    
    let setIndex: Int
    
    var body: some View {
        
        ZStack{
            Color(bgColor)
                .ignoresSafeArea()
            
            VStack{
                
                Text("Set " + String(setIndex+1))
                    .font(.system(size:30))
                    .foregroundColor(Color.white)
                    .padding(.top, 50)
                
                HStack{
                    Text("Well")
                        .foregroundColor(Color.white)
                    
                    Text("Done")
                        .foregroundColor(accentColor)
                }
                .font(.system(size:40))
                .padding(.top, 20)
                
                Spacer()
                
                Image(systemName: "flame.fill")
                    .foregroundColor(accentColor)
                    .font(.system(size:180))
                
                Spacer()
                
                Text("You did it, come back tomorrow for your daily exercise.")
                    .foregroundColor(Color.white)
                    .font(.system(size:28))
                    .frame(width: 340)
                    .padding(.bottom, 50)
            }
        }
    }
}

struct CongratsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
