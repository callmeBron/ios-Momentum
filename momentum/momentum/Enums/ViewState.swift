import Foundation

enum ViewState {
    case data(AccountModel) // make generic
    case onboarding(String)
    case noContent
}
