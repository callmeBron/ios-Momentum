import SwiftUI
import FictionalInjection

struct ProfileView<viewModel: AccountViewModelProtocol>: View {
    @State private var profileNavRoutes: [ProfileRoute] = []
    @State private var shouldShowAccountSetup: Bool = false
    
    @StateObject private var model: viewModel
    private let  intents: AccountIntentProtocol
    
    private let navigationFactory: ProfileNavigationFactory
    
    init(model: viewModel, intents: AccountIntentProtocol, navigationFactory: ProfileNavigationFactory) {
        self._model = StateObject(wrappedValue: model)
        self.intents = intents
        self.navigationFactory = navigationFactory
    }
    
    var body: some View {
        switch model.viewState {
        case .noContent:
            EmptyView()
        case .onboarding(let onboardingModel):
            onboardingState(onboardingModel: onboardingModel)
        case .data(let dataModel):
            profileState(dataModel: dataModel)
        }
    }
    
    @ViewBuilder
    private func onboardingState(onboardingModel: OnboardingModel) -> some View {
        ZStack(alignment: .bottom) {
            OnboardingView(imageName: onboardingModel.imageName,
                           title: onboardingModel.title,
                           description: onboardingModel.description)
            Button {
                intents.setOnboardingSeen()
                shouldShowAccountSetup.toggle()
            } label: {
                Text(onboardingModel.buttonText)
                    .foregroundStyle(.white)
            }
            .padding()
            .background(.darkCharcoal)
            .clipShape(Capsule())
        }.sheet(isPresented: $shouldShowAccountSetup,
                onDismiss: {
            model.fetch()
        }, content: {
            navigationFactory.getScreen(for: .editAccount)
        })
    }
    
    @ViewBuilder
    private func profileState(dataModel: AccountModel) -> some View{
        NavigationStack(path: $profileNavRoutes) {
            VStack {
                accountEditButtonView()
                accountTopSectionView(image: dataModel.profileImage,
                                      profileName: dataModel.profileName,
                                      username: dataModel.profileUsername)
                accountListView(accountSection: dataModel.accountSections)
            }
            .navigationDestination(for: ProfileRoute.self, destination: { route in
                navigationFactory.getScreen(for: route)
            })
            .padding(.vertical)
            .sheet(isPresented: $shouldShowAccountSetup,
                   onDismiss: {
                model.fetch()
            }, content: {
                navigationFactory.getScreen(for: .editAccount)
            })
        }
    }
    
    @ViewBuilder
    private func accountEditButtonView() -> some View {
        HStack {
            Spacer()
            Button {
                profileNavRoutes.append(.editAccount)
            } label: {
                Text("Edit")
                    .bold()
                    .font(.body)
                    .foregroundStyle(.darkCharcoal)
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func accountTopSectionView(image: Image, profileName: String, username: String) -> some View {
        image
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
            .padding()
            .background(Color.purple)
            .clipShape(Circle())
        
        Text(profileName)
            .font(.title2)
            .bold()
        
        Text(username)
            .font(.caption)
            .foregroundStyle(.gray)
    }
    
    @ViewBuilder
    private func accountListView(accountSection: AccountSection) -> some View {
        List {
            Section {
                ForEach(accountSection.items, id: \.id) { item in
                    setSectionItem(itemName: item.itemName) {
                        profileNavRoutes.append(item.routeType)
                    }
                }
            }
            Section {
                Button {
                    // delete account
                } label: {
                    Text("Delete Account")
                        .foregroundStyle(.red)
                        .bold()
                }
                
            }
        }
        .listStyle(.insetGrouped)
    }
    
    @ViewBuilder
    private func setSectionItem(itemName: String, buttonAction: @escaping () -> Void) -> some View {
        Button(itemName) {
            buttonAction()
        }
    }
}
