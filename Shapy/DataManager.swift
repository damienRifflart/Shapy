import SwiftUI

class DataManager: ObservableObject {
    @Published var currentSerie: Int = 1
    @Published var exerciceOne: String = "First"
    @Published var exerciceTwo: String = ""
    @Published var exerciceThree: String = ""
    @Published var exerciceFour: String = ""
    @Published var exerciceIndex: Int = 0
}
