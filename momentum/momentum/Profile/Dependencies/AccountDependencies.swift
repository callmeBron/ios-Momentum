import Foundation
import SwiftUICore
import FictionalInjection

class AccountDependencies {
    func bindAccountDependencies() {
        Container.bucket.addToBucket(ProfileNavigationFactory.self) { _ in
            ConcreteProfileNavigationFactory()
        }
        
        Container.bucket.addToBucket(AccountIntentProtocol.self) { _ in
            AccountIntents()
        }
        
        Container.bucket.addToBucket((any AccountViewProtocol).self, name: "AccountViewModel") {_ in
            AccountViewModel()
        }
        
        Container.bucket.addToBucket(AnyView.self, name: BindingName.accountBindingName) { resolver in
            AnyView(ProfileView(model: resolver.resolve((any AccountViewProtocol).self, name: "AccountViewModel") as! AccountViewModel,
                                intents: resolver.resolve(AccountIntentProtocol.self),
                                navigationFactory: resolver.resolve(ProfileNavigationFactory.self)))
        }
        
        Container.bucket.addToBucket(UpdateAccountIntentProtocol.self) { _ in
            UpdateAccountIntents()
        }
        
        Container.bucket.addToBucket(AnyView.self, name: BindingName.accountUpdateBindingName) { resolver in
            AnyView(UpdateAccountView(viewModel: UpdateAccountViewModel(),
                                      intents: resolver.resolve(UpdateAccountIntentProtocol.self)))
        }
    }
}

extension BindingName {
    static let accountBindingName = "accountBindingName"
    static let accountUpdateBindingName = "accountUpdateBindingName"
}
