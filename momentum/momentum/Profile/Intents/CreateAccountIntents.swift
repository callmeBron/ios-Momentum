import SwiftUI

protocol UpdateAccountIntentProtocol {
    func saveUserContext(firstName: String, lastName: String, username: String, bio: String)
}

class UpdateAccountIntents: UpdateAccountIntentProtocol {
    @Environment(\.modelContext) var userModelContext
    
    func saveUserContext(firstName: String, lastName: String, username: String, bio: String) {
        let userModel = PersistedProfileModel(userImage: Data(),
                                              firstName: firstName,
                                              lastName: lastName,
                                              username: username,
                                              userBio: bio)
        
        userModelContext.insert(userModel)
    }
}
