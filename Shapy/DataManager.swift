import SwiftUI

class DataManager: ObservableObject {
    @Published var currentSerie: Int = 1
    @Published var exerciceOne: String = "15 Pompes"
    @Published var exerciceTwo: String = "30 Abdos"
    @Published var exerciceThree: String = ""
    @Published var exerciceFour: String = ""
    @Published var exerciceIndex: Int = 0
}
