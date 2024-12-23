import Foundation

class InitialOnboardingViewModel: OnboardingProtocol {
    var dataModel: OnboardingModel?
    
    init() {
        setDataModel()
    }
    private func setDataModel() {
        dataModel = OnboardingModel(imageName: "welcome-image",
                                    title: "Welcome To Momentum",
                                    description: "Where every action counts and progression becomes second nature. Let’s build your Momentum one habit at a time.",
                                    buttonText: "Get Started")
    }
}
