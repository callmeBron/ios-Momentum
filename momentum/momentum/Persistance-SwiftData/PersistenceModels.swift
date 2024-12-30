import SwiftUI
import SwiftData

@Model
class PersistedProfileModel {
    var userImage: Data
    var firstName: String
    var lastName: String
    var username: String
    var userBio: String
 
    init(userImage: Data, firstName: String, lastName: String, username: String, userBio: String) {
        self.userImage = userImage
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.userBio = userBio
    }
}
