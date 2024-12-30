import SwiftUICore
import FictionalInjection

protocol ProfileNavigationFactory {
    func getScreen(for route: ProfileRoute) -> AnyView
}

class ConcreteProfileNavigationFactory: ProfileNavigationFactory {
    @Inject(BindingName.accountUpdateBindingName) var accountUpdaterView: AnyView!
    
    func getScreen(for route: ProfileRoute) -> AnyView {
        switch route {
        case .habitHistory:
            AnyView(Text("Habit History"))
        case .notifications:
            AnyView(Text("Notifications"))
        case .settings:
            AnyView(Text("Settings"))
        case .editAccount:
            accountUpdaterView
        }
    }
}
