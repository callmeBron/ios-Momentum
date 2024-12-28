import Foundation
import SwiftUICore
import FictionalInjection

class AccountOnboardingViewModel: OnboardingProtocol, ObservableObject {
    var dataModel: OnboardingModel?
  
    init() {
        setDataModel()
    }
    
    private func setDataModel() {
        @Inject(BindingName.accountCreateBindingName) var createView: AnyView!
        dataModel = OnboardingModel(imageName: "account-image",
                                    title: "Account Set Up",
                                    description: "Tell us a little about yourself so we can personalise your experience. Every step forward is a step towards your best self.",
                                    buttonText: "Lets Go",
                                    nextView: createView)
    }
}
