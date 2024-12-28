import Foundation
import FictionalInjection
import SwiftUI

class InitialOnboardingIntents: OnboardingIntentProtocol {
    func onboardingButtonAction() {
        // action to come
    }
}

class AccountOnboardingIntents: OnboardingIntentProtocol {
    func onboardingButtonAction() {
        @Inject(BindingName.accountBindingName) var profileView: AnyView!
        NavigationLink("") {
            profileView
        }
    }
}

class HabitOnboardingIntents: OnboardingIntentProtocol {
    func onboardingButtonAction() {
        // action to come
    }
}

class StatisticOnboardingIntents: OnboardingIntentProtocol {
    func onboardingButtonAction() {
        // action to come
    }
}
