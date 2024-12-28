import Foundation

protocol OnboardingProtocol {
    var dataModel: OnboardingModel? { get }
}

protocol OnboardingIntentProtocol {
    func onboardingButtonAction()
}
