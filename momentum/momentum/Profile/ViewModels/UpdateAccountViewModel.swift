import SwiftUI
import SwiftData
import PhotosUI

class UpdateAccountViewModel: ObservableObject, AccountUpdaterProtocol {
    @Published var selectedImage: Image = Image("account-image")
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var username: String = ""
    @Published var bio: String = ""
    
    var dataModel: AccountUpdaterModel?
    
    init() {
        setDataModel()
    }
    
    private func setDataModel() {
        dataModel = AccountUpdaterModel(textFields: [TextFieldModel(fieldType: .singleLine,
                                                                    fieldTitle: "first name",
                                                                    text: Binding(get: { self.firstName }, set: { [weak self] value in self?.firstName = value }),
                                                                    promptText: "John",
                                                                    focusedState: .firstname,
                                                                    actionButtonLabel: .next),
                                                     TextFieldModel(fieldType: .singleLine,
                                                                    fieldTitle: "last name",
                                                                    text: Binding(get: { self.lastName }, set: { [weak self] value in self?.lastName = value }),
                                                                    promptText: "Appleseed",
                                                                    focusedState: .lastname,
                                                                    actionButtonLabel: .next),
                                                     TextFieldModel(fieldType: .singleLine,
                                                                    fieldTitle: "username",
                                                                    text: Binding(get: { self.username }, set: { [weak self] value in self?.username = value }),
                                                                    promptText: "JJAppleseed",
                                                                    focusedState: .username,
                                                                    actionButtonLabel: .next),
                                                     TextFieldModel(fieldType: .multiLine,
                                                                    fieldTitle: "Bio",
                                                                    text: Binding(get: { self.bio }, set: { [weak self] value in self?.bio = value }),
                                                                    promptText: "Tell us about yourself",
                                                                    focusedState: .bio,
                                                                    actionButtonLabel: .done)])
        
    }
}
