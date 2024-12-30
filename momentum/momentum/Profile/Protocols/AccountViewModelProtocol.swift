import Foundation
import SwiftUI

protocol AccountViewModelProtocol: ObservableObject, AnyObject {
    var onboardingHasbeenSeen: Bool { get }
    var viewState: ViewState<AccountModel> { get }
    func fetch()
}

protocol AccountUpdaterProtocol: ObservableObject {
    var selectedImage: Image { get set }
    var dataModel: AccountUpdaterModel? { get }
}
