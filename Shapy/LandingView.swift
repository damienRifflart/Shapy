import SwiftUI

extension Color {
    init(hex: Int) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}

struct LandingView: View {
    @State private var isExerciceViewActive = false
    @State private var isSettingsViewActive = false
    @ObservedObject var variables: DataManager

    var body: some View {
        ZStack{
            // Background Color
            Color(hex: 0x0E0215)
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
                // Title Text
                HStack{
                    Spacer()
                    Text("v0.8")
                        .foregroundColor(Color.gray.opacity(0.5))
                        .font(.system(size:25))
                        .padding(.top,150)
                    Spacer()
                    
                    Text("Bienvenue")
                        .foregroundColor(Color.white)
                        .font(.system(size: 50))
                        .padding(.top, 150)
                        .padding(.trailing, 60)
                    
                    Spacer()
            
                }
                
                Text("Damien")
                    .foregroundColor(Color(hex: 0xE6D2F7))
                    .font(.system(size: 50))
                    .fontWeight(.semibold)
                    .padding(.bottom, 20)
                
                Image("mockup")
                Spacer()
                
                // Settings Button
                Button(action: { isSettingsViewActive.toggle()
                }) {
                    Text("Paramètre")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(Color(hex: 0x0E0215))
                        .padding()
                        .frame(width: 300, height:60)
                        .background(Color(hex: 0xE6D2F7))
                        .cornerRadius(10)
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                }
                
                // Start Button
                Button(action: { isExerciceViewActive.toggle()
                }) {
                    Text("Commencer")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(Color(hex: 0x0E0215))
                        .padding()
                        .frame(width: 300, height:60)
                        .background(Color(hex: 0xE6D2F7))
                        .cornerRadius(10)
                        .padding(.bottom, 200)
                }
            }
            .fullScreenCover(isPresented: $isExerciceViewActive) {
                ExerciceView(variables: variables)
            }
                
            .fullScreenCover(isPresented: $isSettingsViewActive) {
                SettingsView(variables: variables)
                
            }
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    @StateObject static var dataManager = DataManager()

    static var previews: some View {
        LandingView(variables: dataManager)
    }
}

