//
//  Timer.swift
//  Shapy
//
//  Created by Damien Rifflart on 17/09/2023.
//

import SwiftUI

let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
let defaultBreakTimeRemaining: CGFloat = 1
let defaultSportTimeRemaining: CGFloat = 1

struct TimerViewBreak: View {
    
    let lineWidth: CGFloat = 20
    let radius: CGFloat = 110
    var isActive: Bool = true
    
    @Binding var breakViewActive: Bool
    
    @Binding var setIndex: Int
    @Binding var exerciseIndex: Int
    
    @State private var timeRemaining: CGFloat = defaultBreakTimeRemaining
    
    var body: some View {
        
        VStack(spacing: 25) {
            
            // Circles on top of each others
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                
                Circle()
                    .trim(from: 1 - (timeRemaining / defaultBreakTimeRemaining), to: 1)
                    
                    // Stroke color
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
            if timeRemaining > 0 {
                timeRemaining -= 1
                
            } else {
                
                if exerciseIndex == 2{
                    
                    // If all sets have been done
                    if setIndex == 2{
                        // TODO: Congratulation View
                        
                        setIndex = 0
                        exerciseIndex = -1
                        
                    // If only one set has been done
                    } else {
                        // Putting exerciseIndex to -1 because it will increase after to 0
                        exerciseIndex = -1
                        setIndex += 1
                    }
                }
                
                exerciseIndex += 1
                
                breakViewActive = false
                
            }
        })
    }
}

struct TimerViewSport: View {
    
    let lineWidth: CGFloat = 20
    let radius: CGFloat = 110
    var isActive: Bool = true
    
    @Binding var breakViewActive: Bool
    
    @State private var timeRemaining: CGFloat = defaultSportTimeRemaining
    
    var body: some View {
        
        VStack(spacing: 25) {
            
            // Circles on top of each others
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                
                Circle()
                    .trim(from: 1 - (timeRemaining / defaultSportTimeRemaining), to: 1)
                    
                    // Stroke color
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
            if timeRemaining > 0 {
                timeRemaining -= 1
                
            } else {

                breakViewActive = true

            }
        })
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
