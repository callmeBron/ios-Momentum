import Foundation
import SwiftUI

class AccountViewModel: ObservableObject, AccountViewProtocol {
    @Published var viewState: ViewState = .noContent
    
    private var shouldShowOnboarding: Bool  {
        return false
    }
    
    init() {
        shouldShowOnboarding ? setOnboardingState() : setDataModel()
    }
    
    private func setOnboardingState() {
        viewState = .onboarding("AccountOnboardingBindingName") // will use binding name to id the correct onboarding
    }
    
    private func setDataModel() {
        let dataModel = AccountModel(profileImage: Image("account-image"),
                                 profileName: "Bronwyn dos Santos",
                                 profileUsername: "@bronwyn.d.santos",
                                 accountSections: [AccountSection(items: [AccountItem(itemName: "Settings",
                                                                                      itemType: .normal),
                                                                          AccountItem(itemName: "Notifications",
                                                                                      itemType: .normal)]),
                                                   AccountSection(items: [AccountItem(itemName: "Delete Account",
                                                                                      itemType: .destructive)])])
        viewState = .data(dataModel)
      
    }
}
