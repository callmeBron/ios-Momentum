import SwiftUI

struct AccountUpdaterModel {
    let textFields: [TextFieldModel]
}

struct TextFieldModel {
    let fieldType: FieldType
    let fieldTitle: String
    let text: Binding<String>
    let promptText: String
    let focusedState: FocusedField
    let actionButtonLabel: SubmitLabel
}
