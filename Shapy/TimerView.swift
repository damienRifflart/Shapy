//
//  Timer.swift
//  Shapy
//
//  Created by Damien Rifflart on 17/09/2023.
//

import SwiftUI

let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()

struct TimerViewBreak: View {
    
    let lineWidth: CGFloat = 20
    let radius: CGFloat = 110
    var isActive: Bool = true
    
    let test: CGFloat = 1
    
    @Binding var breakViewActive: Bool
    
    @Binding var setIndex: Int
    @Binding var exerciseIndex: Int
    @Binding var breakTime: Int
    
    @State private var timeRemaining: Int
    
    init(breakViewActive: Binding<Bool>, setIndex: Binding<Int>, exerciseIndex: Binding<Int>, breakTime: Binding<Int>) {
        self._breakViewActive = breakViewActive
        self._setIndex = setIndex
        self._exerciseIndex = exerciseIndex
        self._breakTime = breakTime
        
        // Initialize timeRemaining with the initial value of breakTime
        _timeRemaining = State(initialValue: breakTime.wrappedValue)
    }
    
    var body: some View {
        
        VStack(spacing: 25) {
            
            // Circles on top of each others
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                
                Circle()
                    .trim(from: 1 - (CGFloat(timeRemaining) / CGFloat(breakTime)), to: 1)
                    
                    // Stroke color
                    .stroke(timeRemaining > Int(0.66) ? Color.green : timeRemaining > Int(0.33) ? Color.yellow : Color.red, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                    
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
    
    @Binding var setIndex: Int
    @Binding var exerciseIndex: Int
    @Binding var breakViewActive: Bool
    var setExercises: [[Exercise]]
    
    @State var defaultTimeRemaining: CGFloat
    @State private var timeRemaining: CGFloat

    init(setIndex: Binding<Int>, exerciseIndex: Binding<Int>, breakViewActive: Binding<Bool>, setExercises: [[Exercise]]) {
        self._setIndex = setIndex
        self._exerciseIndex = exerciseIndex
        self._breakViewActive = breakViewActive
        
        self.setExercises = setExercises
        
        // Extract values from bindings
        let setIndexValue = setIndex.wrappedValue
        let exerciseIndexValue = exerciseIndex.wrappedValue
        
        let defaultTimeRemaining = Self.calculateTimeRemaining(setExercises: setExercises, setIndex: setIndexValue, exerciseIndex: exerciseIndexValue)
        self._defaultTimeRemaining = State(initialValue: CGFloat(defaultTimeRemaining))
        self._timeRemaining = State(initialValue: CGFloat(defaultTimeRemaining))
    }
    
    // Function to calculate defaultTimeRemaining
    static func calculateTimeRemaining(setExercises: [[Exercise]], setIndex: Int, exerciseIndex: Int) -> Int {
        if setExercises.count > 0 && setExercises[0].count > 0 {
            
            switch setExercises[setIndex][exerciseIndex].name {
                case "Pull-Ups":
                    return setExercises[setIndex][exerciseIndex].number * 3
                    
                case "Push-Ups":
                    return setExercises[setIndex][exerciseIndex].number * 2
                    
                case "Plank":
                    return setExercises[setIndex][exerciseIndex].number
                    
                case "Crunch":
                    return setExercises[setIndex][exerciseIndex].number * 1
                    
                default:
                    return 0
            }
        }
        return 0
    }
    
    var body: some View {
        
        VStack(spacing: 25) {
            
            // Circles on top of each others
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                
                Circle()
                    .trim(from: 1 - (timeRemaining / defaultTimeRemaining), to: 1)
                
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
