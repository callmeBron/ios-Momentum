import Foundation
import SwiftUI
import FictionalInjection

class AccountViewModel: ObservableObject, AccountViewProtocol {
    @Published var viewState: ViewState<AccountModel> = .noContent
    
    private var shouldShowOnboarding: Bool  {
        return true
    }
    
    init() {
        shouldShowOnboarding ? setOnboardingState() : setDataModel()
    }
    
    private func setOnboardingState() {
        viewState = .onboarding(BindingName.accountBindingName)
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
