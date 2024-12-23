import Foundation
import SwiftUI

enum AccountItemType {
    case normal
    case destructive
}

struct AccountModel {
    let profileImage: Image
    let profileName: String
    let profileUsername: String
    let accountSections: [AccountSection]
}

struct AccountSection {
    let id: UUID = UUID()
    let items: [AccountItem]
}

struct AccountItem {
    let id: UUID = UUID()
    let itemName: String
    let itemType: AccountItemType
}
