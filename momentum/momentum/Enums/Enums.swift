import Foundation
import FictionalInjection

enum ViewState<Model> {
    case data(Model)
    case onboarding(String)
    case noContent
}

enum FocusedField {
    case firstname, lastname, username, bio
}

enum FieldType {
    case singleLine, verticalField
}
