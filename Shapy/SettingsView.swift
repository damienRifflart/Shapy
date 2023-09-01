import SwiftUI

struct SettingsView: View {
    @ObservedObject var variables: DataManager
    @State private var isLandingViewActive = false
    @State private var exerciceOneInput = ""
    @State private var exerciceTwoInput = ""
    @State private var exerciceThreeInput = ""
    @State private var exerciceFourInput = ""
    
    func saveButton(){
        isLandingViewActive.toggle()
        variables.exerciceOne = exerciceOneInput
        variables.exerciceTwo = exerciceTwoInput
        variables.exerciceThree = exerciceThreeInput
        variables.exerciceFour = exerciceFourInput
    }
    
    var body: some View {
        
        ZStack{
            // Background Color
            Color(hex: 0x0E0215)
                .ignoresSafeArea()
            
            VStack{
                HStack{
                    // Back Button
                    Button(action: { isLandingViewActive.toggle() }) {
                        Text("Retour")
                            .font(.system(size: 27, weight: .semibold))
                            .foregroundColor(Color(hex: 0x0E0215))
                            .padding()
                            .frame(width: 130, height:60)
                            .background(Color(hex: 0xE6D2F7))
                            .cornerRadius(10)
                    }
                    .padding(.leading, 20)
                    
                    Spacer()
                    
                    // Save Button
                    Button(action: { saveButton() }) {
                        Text("Enregistrer")
                            .font(.system(size: 27, weight: .semibold))
                            .foregroundColor(Color(hex: 0x0E0215))
                            .padding()
                            .frame(width: 188, height:60)
                            .background(Color(hex: 0xE6D2F7))
                            .cornerRadius(10)
                    }
                    .padding(.trailing, 20)
                    
                }
                .fullScreenCover(isPresented: $isLandingViewActive) {
                    LandingView(variables: variables)
                }
                
                Spacer()
                
                // Exercice 1
                Text("Exercice 1")
                    .foregroundColor(Color.white)
                    .font(.system(size:35, weight:.bold))
                    .padding(.leading, 40.0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                TextField(" 15 Pompes", text: $exerciceOneInput)
                    .background(Color.gray.opacity(0.2))
                    .foregroundColor(Color(hex: 0xE6D2F7))
                    .frame(width: 300)
                    .cornerRadius(6)
                    .font(.system(size:40))
                    .padding(.top, -20)
                    .padding(.bottom, 20)
                
                
                // Exercice 2
                Text("Exercice 2")
                    .foregroundColor(Color.white)
                    .font(.system(size:35, weight:.bold))
                    .padding(.leading, 40.0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                TextField(" 25 Abdos", text: $exerciceTwoInput)
                    .background(Color.gray.opacity(0.2))
                    .foregroundColor(Color(hex: 0xE6D2F7))
                    .frame(width: 300)
                    .cornerRadius(6)
                    .font(.system(size:40))
                    .padding(.top, -20)
                    .padding(.bottom, 20)
                
                
                // Exercice 3
                Text("Exercice 3")
                    .foregroundColor(Color.white)
                    .font(.system(size:35, weight:.bold))
                    .padding(.leading, 40.0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                TextField(" 10 Fentes", text: $exerciceThreeInput)
                    .background(Color.gray.opacity(0.2))
                    .foregroundColor(Color(hex: 0xE6D2F7))
                    .frame(width: 300)
                    .cornerRadius(6)
                    .font(.system(size:40))
                    .padding(.top, -20)
                    .padding(.bottom, 20)
                
                
                // Exercice 4
                Text("Exercice 4")
                    .foregroundColor(Color.white)
                    .font(.system(size:35, weight:.bold))
                    .padding(.leading, 40.0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                TextField(" 5 Squats", text: $exerciceFourInput)
                    .background(Color.gray.opacity(0.2))
                    .foregroundColor(Color(hex: 0xE6D2F7))
                    .frame(width: 300)
                    .cornerRadius(6)
                    .font(.system(size:40))
                    .padding(.top, -20)
                    
                
                
            }
            .padding(.bottom, 50.0)
            
            
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(variables: DataManager())
    }
}
