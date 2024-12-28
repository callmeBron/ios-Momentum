import Foundation

class StatisticOnboardingViewModel: OnboardingProtocol {
    var dataModel: OnboardingModel?
    
    init() {
        setDataModel()
    }
    private func setDataModel() {
        dataModel = OnboardingModel(imageName: "stats-image",
                                    title: "Your Stats",
                                    description: "See how far you’ve come. Your habits tell a story of growth, progress, and potential. Track your stats, celebrate your wins, and keep building momentum every day.",
                                    buttonText: "Awesome!")
    }
}
