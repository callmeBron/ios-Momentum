import Foundation
import FictionalInjection

enum ViewState<Model> {
    case data(Model)
    case onboarding(OnboardingModel)
    case noContent
}

enum ProfileRoute: Hashable {
    case habitHistory, notifications, settings, editAccount
}

enum FocusedField {
    case firstname, lastname, username, bio
}

enum FieldType {
    case singleLine, multiLine
}


