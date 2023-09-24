import SwiftUI

struct Exercise {
    var name: String
    var number: Int
}

struct ContentView: View {
    
    // Tab Index
    @State private var selectedTab = 0
    
    // Colors
    let backgroundColor = CGColor(red: 5/255, green: 5/255, blue: 5/255, alpha: 1)
    let secondColor = CGColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
    let accentColor = Color(red: 242/255, green: 142/255, blue: 61/255)
    
    // Sport variables
    @State private var breakTime: Int = 1
    
    @State private var setExercises: [[Exercise]] = [
        [
            Exercise(name: "Pull-Ups", number: 1),
            Exercise(name: "Push-Ups", number: 1),
            Exercise(name: "Plank", number: 1)
        ],
        [
            Exercise(name: "Pull-Ups", number: 1),
            Exercise(name: "Push-Ups", number: 1),
            Exercise(name: "Plank", number: 1)
        ],
        [
            Exercise(name: "Pull-Ups", number: 1),
            Exercise(name: "Push-Ups", number: 1),
            Exercise(name: "Plank", number: 1)
        ]
    ]
    
    var body: some View {
        
        // Navigation Bar
        TabView(selection: $selectedTab) {
            
            HomeView(bgColor: backgroundColor, accentColor: accentColor, selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(0)

            SportView(bgColor: backgroundColor, accentColor: accentColor,
                      selectedTab: $selectedTab, setExercises: $setExercises, breakTime: $breakTime)
                .tabItem {
                    Image(systemName: "bolt.square.fill")
                }
                .tag(1)

            SettingsView(bgColor: backgroundColor, secondColor: secondColor, accentColor: accentColor, selectedTab: $selectedTab, setExercises: $setExercises, breakTime: $breakTime)
                .tabItem {
                    Image(systemName: "gearshape.fill")
                }
                .tag(2)
        }
        .accentColor(accentColor)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
