import Foundation
import SwiftUICore
import FictionalInjection

class AccountDependencies {
    func bindAccountDependencies() {
        Container.bucket.addToBucket(AccountIntentProtocol.self) { _ in
            AccountIntents()
        }
        
        Container.bucket.addToBucket(AccountViewProtocol.self) {_ in
            AccountViewModel()
        }
        
        Container.bucket.addToBucket(AnyView.self, name: BindingName.accountBindingName) { resolver in
            AnyView(ProfileView(viewModel: resolver.resolve(AccountViewProtocol.self),
                                intents: resolver.resolve(AccountIntentProtocol.self)))
        }
        
        Container.bucket.addToBucket(AnyView.self, name: BindingName.accountCreateBindingName) { _ in
            AnyView(CreateAccountView())
        }
    }
}

extension BindingName {
    static let accountBindingName = "accountBindingName"
    static let accountCreateBindingName = "accountCreateBindingName"
}
