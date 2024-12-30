import Foundation
import SwiftUI
import SwiftData
import FictionalInjection

class AccountViewModel: AccountViewModelProtocol {
    @Query var userInformation: [PersistedProfileModel]
    let hasSeenOnboardingUserDefault = UserDefaults.standard
    @Published var viewState: ViewState<AccountModel> = .noContent
    
    var onboardingHasbeenSeen: Bool {
        hasSeenOnboardingUserDefault.bool(forKey: "AccountOnboardingSeen")
    }
    
    init() {
        fetch()
    }
    
    func fetch() {
        onboardingHasbeenSeen ? setDataState() : setOnboardingState()
    }
    
    private func setDataState() {
        viewState = .data(AccountModel(profileImage: Image("account-image"),
                                       profileName: "userInformation[0].firstName" + " " + "userInformation[0].lastName",
                                       profileUsername: "userInformation[0].username",
                                       profileBio: "userInformation[0].userBio",
                                       accountSections: setSections()))
    }
    
    private func setOnboardingState() {
        viewState = .onboarding(OnboardingModel(imageName: "account-image",
                                                title: "Account Set Up",
                                                description: "Tell us a little about yourself so we can personalise your experience. Every step forward is a step towards your best self.",
                                                buttonText: "Lets Go"))
    }
    
    private func setSections() -> AccountSection {
        let section = AccountSection(items: [AccountItem(itemName: "Account Settings", routeType: .settings),
                                             AccountItem(itemName: "Notification Settings", routeType: .notifications),
                                             AccountItem(itemName: "Habit History", routeType: .habitHistory)
                                            ])
        
        return section
    }
}
