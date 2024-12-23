import SwiftUI

struct ProfileView: View {
    var viewModel: AccountViewProtocol
    var intents: AccountIntentProtocol
    
    init(viewModel: AccountViewProtocol, intents: AccountIntentProtocol) {
        self.viewModel = viewModel
        self.intents = intents
    }
    
    var body: some View {
        switch viewModel.viewState {
        case .data(let accountModel):
            NavigationView {
                VStack {
                    accountEditButtonView(action: intents.editButtonIntent)
                    accountTopSectionView(image: accountModel.profileImage,
                                          profileName: accountModel.profileName,
                                          username: accountModel.profileUsername)
                    accountListView(accountSections: accountModel.accountSections)
                }
                .padding(.vertical)
            }
        case .onboarding(_):
            // resolve by binding name
            OnboardingView(viewModel: AccountOnboardingViewModel(),
                           intents: AccountOnboardingIntents())
        case .noContent:
            Text("We Were unable to load your profile")
        }
      
    }
    
}

@ViewBuilder
private func accountEditButtonView(action: @escaping () -> Void) -> some View {
    HStack {
        Spacer()
        VStack {
            Button {
                action()
            } label: {
                VStack {
                    Text("Edit")
                        .bold()
                        .font(.caption)
                }
                .foregroundStyle(.darkCharcoal)
            }
            
        }.padding(.horizontal)
    }
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
private func accountListView(accountSections: [AccountSection]) -> some View {
    List {
        ForEach(accountSections, id: \.id) { accountSection in
            Section {
                ForEach(accountSection.items, id: \.id) { item in
                    setSectionItem(on: item.itemType, itemName: item.itemName)
                }
            }
        }
    }
    .listStyle(.insetGrouped)
}

@ViewBuilder
private func setSectionItem(on type: AccountItemType, itemName: String) -> some View {
    switch type {
    case .normal:
        NavigationLink(itemName,
                       destination: Text("history"))
    case .destructive:
        Button {
            // action
        } label: {
            Text(itemName)
                .bold()
                .foregroundStyle(.red)
        }
    }
}
