import Foundation
import SwiftUI

protocol AccountIntentProtocol {
  func setOnboardingSeen()
}

class AccountIntents: AccountIntentProtocol {
    let userDefaults = UserDefaults.standard
    func setOnboardingSeen() {
        userDefaults.set(true, forKey: "AccountOnboardingSeen")
    }
}
