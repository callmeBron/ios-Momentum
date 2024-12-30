import Foundation
import SwiftUI

struct AccountModel {
    let profileImage: Image
    let profileName: String
    let profileUsername: String
    let profileBio: String
    let accountSections: AccountSection
}

struct AccountSection {
    let id: UUID = UUID()
    let items: [AccountItem]
}

struct AccountItem {
    let id: UUID = UUID()
    let itemName: String
    let routeType: ProfileRoute
}
