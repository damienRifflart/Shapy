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
    
    var body: some View{
        
        ZStack{
            Color(bgColor)
                .ignoresSafeArea()
            
            VStack{
                Text("Set 1")
                    .foregroundColor(Color.white)
                    .font(.system(size:30))
                    .padding(.top, 60)
                
                Spacer()
                
                HStack{
                    Text("40s")
                        .foregroundColor(Color.white)
                    
                    Text("Break")
                        .foregroundColor(accentColor)
                }
                .font(.system(size:50))
                
                Spacer()
                
                // Timer
                TimerView(breakViewActive: $breakViewActive, forBreakMode: true)
                
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
    @State var breakViewActive:Bool = false
    
    var body: some View {
        
        ZStack{
            Color(bgColor)
                .ignoresSafeArea()
            
            VStack{
                
                Text("Set 1")
                    .foregroundColor(Color.white)
                    .font(.system(size:30))
                    .padding(.top, 60)
                Spacer()
                
                
                // Exercise Text
                VStack{
                    Text("15")
                        .font(.system(size:50))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                    
                    Text("Push-Ups")
                        .foregroundColor(Color.accentColor)
                        .font(.system(size:50))
                }
                
                if !breakViewActive{
                    if selectedTab == 1{
                        TimerView(breakViewActive: $breakViewActive, forBreakMode: false)
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
                            BreakView(bgColor: bgColor, accentColor: accentColor, breakViewActive: $breakViewActive)
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
