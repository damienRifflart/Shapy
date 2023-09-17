//
//  Timer.swift
//  Shapy
//
//  Created by Damien Rifflart on 17/09/2023.
//

import SwiftUI

let defaultTimeRemaining: CGFloat = 5
let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
var isActive = true

struct TimerView: View {
    
    let lineWidth: CGFloat = 20
    let radius: CGFloat = 110
    
    @Binding var breakViewActive: Bool
    @State var forBreakMode: Bool
    @State private var timeRemaining: CGFloat = defaultTimeRemaining
    
    var body: some View {
        
        VStack(spacing: 25) {
            
            // Circles on top of each others
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                
                Circle()
                    .trim(from: 1 - (timeRemaining / defaultTimeRemaining), to: 1)
                    
                    // Condition pour la couleur du trait
                    .stroke(timeRemaining > 0.66 ? Color.green : timeRemaining > 0.33 ? Color.yellow : Color.red, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                    
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut, value: timeRemaining)
                    
                Text("\(Int(timeRemaining))")
                    .font(.system(size: 50))
                    .foregroundColor(Color.white)
            }
            .frame(width: radius * 2, height: radius * 2)
        }
        
        .onReceive(timer, perform: { _ in
            guard isActive else { return }
            if timeRemaining > 0.5 {
                timeRemaining -= 1
                
            } else {
                
                // if that was called from sportview
                if !forBreakMode{
                    breakViewActive = true
                    timeRemaining = defaultTimeRemaining
                    
                // if that was called from breakview
                } else {
                    breakViewActive = false
                }
            }
        })
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
