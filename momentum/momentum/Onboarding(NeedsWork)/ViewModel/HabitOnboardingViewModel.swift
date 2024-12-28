import Foundation
import SwiftUICore

class HabitOnboardingViewModel: OnboardingProtocol, ObservableObject {
    var dataModel: OnboardingModel?
    
    init() {
      setDataModel()
    }
    
    private func setDataModel() {
        dataModel = OnboardingModel(imageName: "habit-image",
                                    title: "First Habit",
                                    description: "What’s one habit you’ve been meaning to build? Whether big or small, every habit starts with intention. Let’s create a plan together.",
                                    buttonText: "Create Habits",
                                    nextView: AnyView(Text("view")))
    }
}
