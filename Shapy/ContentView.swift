import SwiftUI

struct Exercise: Codable, Identifiable {
    var id = UUID()
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
    @State private var username: String = "User"
    
    @State private var setExercises: [[Exercise]] = [
        [
            Exercise(name: "Push-Ups", number: 1),
            Exercise(name: "Push-Ups", number: 1),
            Exercise(name: "Push-Ups", number: 1)
        ],
        [
            Exercise(name: "Push-Ups", number: 1),
            Exercise(name: "Push-Ups", number: 1),
            Exercise(name: "Push-Ups", number: 1)
        ],
        [
            Exercise(name: "Push-Ups", number: 1),
            Exercise(name: "Push-Ups", number: 1),
            Exercise(name: "Push-Ups", number: 1)
        ]
    ]
    
    func saveData() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(setExercises) {
            UserDefaults.standard.set(encodedData, forKey: "exercisesKey")
        }
        
        UserDefaults.standard.set(breakTime, forKey: "breakTimeKey")
        UserDefaults.standard.set(username, forKey: "usernameKey")
    }
    
    func loadData() {
        if let exerciseData = UserDefaults.standard.data(forKey: "exercisesKey"),
           let exercises = try? JSONDecoder().decode([[Exercise]].self, from: exerciseData) {
            setExercises = exercises
        }
        
        if let savedBreakTime = UserDefaults.standard.value(forKey: "breakTimeKey") as? Int {
            breakTime = savedBreakTime
        }
        
        if let savedUsername = UserDefaults.standard.value(forKey: "usernameKey") as? String {
            username = savedUsername
        }
    }
    
    var body: some View {
        
        // Navigation Bar
        TabView(selection: $selectedTab) {
            
            HomeView(bgColor: backgroundColor, accentColor: accentColor, selectedTab: $selectedTab, breakTime: breakTime, setExercises: setExercises, username: username)
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

            SettingsView(bgColor: backgroundColor, secondColor: secondColor, accentColor: accentColor, selectedTab: $selectedTab, setExercises: $setExercises, breakTime: $breakTime, username: $username)
                .tabItem {
                    Image(systemName: "gearshape.fill")
                }
                .tag(2)
        }
        .onAppear {
            loadData()
        }
        
        .onDisappear {
            saveData()
        }
        
        .accentColor(accentColor)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
