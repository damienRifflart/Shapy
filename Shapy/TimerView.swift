//
//  Timer.swift
//  Shapy
//
//  Created by Damien Rifflart on 17/09/2023.
//

import SwiftUI
import AVFoundation

let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()

struct TimerViewBreak: View {
    
    var audioPlayerStart: AVAudioPlayer?
    var audioPlayerEnd: AVAudioPlayer?
    
    let lineWidth: CGFloat = 20
    let radius: CGFloat = 110
    var isActive: Bool = true
    
    @Binding var breakViewActive: Bool
    
    @Binding var setIndex: Int
    @Binding var exerciseIndex: Int
    @Binding var breakTime: Int
    var setExercises: [[Exercise]]
    
    @State private var timeRemaining: Int
    
    init(breakViewActive: Binding<Bool>, setIndex: Binding<Int>, exerciseIndex: Binding<Int>, breakTime: Binding<Int>, setExercises: [[Exercise]]) {
        self._breakViewActive = breakViewActive
        self._setIndex = setIndex
        self._exerciseIndex = exerciseIndex
        self._breakTime = breakTime
        
        // Initialize timeRemaining with the initial value of breakTime
        _timeRemaining = State(initialValue: breakTime.wrappedValue)
        
        self.setExercises = setExercises
        
        if let startSoundURL = Bundle.main.url(forResource: "startSound", withExtension: "mp3"),
            let endSoundURL = Bundle.main.url(forResource: "endSound", withExtension: "mp3") {
            do {
                audioPlayerStart = try AVAudioPlayer(contentsOf: startSoundURL)
                audioPlayerEnd = try AVAudioPlayer(contentsOf: endSoundURL)
            } catch {
                print("Erreur lors du chargement du son : \(error.localizedDescription)")
            }
        }

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
                    .stroke(timeRemaining > (breakTime/3)*2 ? Color.green : timeRemaining > breakTime/3 ? Color.yellow : Color.red, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                    
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
                
                if timeRemaining == 3 || timeRemaining == 2 || timeRemaining == 1{
                self.audioPlayerStart?.play()
                
                } else if timeRemaining == 0 {
                    self.audioPlayerEnd?.play()
                }
                
            } else {

                if exerciseIndex == 2 && setIndex == 2{
                    setIndex = 0
                    exerciseIndex = 0
                        
                // If only one set has been done
                } else {
                    
                    exerciseIndex += 1
                    breakViewActive = false
                
                    while exerciseIndex <= 3 {
                        // Vérifiez si exerciseIndex atteint 2
                        if exerciseIndex == 3{
                            // Si c'est le cas, passez au prochain set et réinitialisez exerciseIndex
                            setIndex += 1
                            exerciseIndex = 0
                        }
                        
                        if setExercises[setIndex][exerciseIndex].name == "None" {
                            // Si l'exercice actuel est "None", passez au suivant
                            exerciseIndex += 1

                        
                        } else {
                            // Si l'exercice n'est pas "None", sortez de la boucle
                            break
                        }
                    }
                }
            }
        })
    }
}

struct TimerViewSport: View {
    
    var audioPlayerStart: AVAudioPlayer?
    var audioPlayerEnd: AVAudioPlayer?
    
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
        
        if let startSoundURL = Bundle.main.url(forResource: "startSound", withExtension: "mp3"),
            let endSoundURL = Bundle.main.url(forResource: "endSound", withExtension: "mp3") {
            do {
                audioPlayerStart = try AVAudioPlayer(contentsOf: startSoundURL)
                audioPlayerEnd = try AVAudioPlayer(contentsOf: endSoundURL)
            } catch {
                print("Erreur lors du chargement du son : \(error.localizedDescription)")
            }
        }
        
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
                    .stroke(timeRemaining > (defaultTimeRemaining/3)*2 ? Color.green : timeRemaining > defaultTimeRemaining/3 ? Color.yellow : Color.red, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                
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
                
                if timeRemaining == 3 || timeRemaining == 2 || timeRemaining == 1{
                self.audioPlayerStart?.play()
                
                } else if timeRemaining == 0 {
                    self.audioPlayerEnd?.play()
                }
                
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
