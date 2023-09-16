import SwiftUI

struct ContentView: View {
    
    // Tab Index
    @State private var selectedTab = 0
    
    // Colors
    let backgroundColor = CGColor(red: 5/255, green: 5/255, blue: 5/255, alpha: 1)
    
    let accentColor = Color(red: 242/55, green: 142/255, blue: 61/255)
    
    var body: some View {
        
        // Navigation Bar
        TabView(selection: $selectedTab) {
            
            HomeView(bgColor: backgroundColor, accentColor: accentColor,            selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(0)

            SportView(bgColor: backgroundColor, accentColor: accentColor,
                      selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "dumbbell.fill")
                }
                .tag(1)

            SettingsView(bgColor: backgroundColor, accentColor: accentColor,
                         selectedTab: $selectedTab)
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

