import SwiftUI

struct OnboardingView: View {
    let viewModel: OnboardingProtocol
    let intents: OnboardingIntentProtocol
    
    var onboardingDataModel: OnboardingModel
    
    init(viewModel: OnboardingProtocol, intents: OnboardingIntentProtocol) {
        self.viewModel = viewModel
        self.intents = intents
        guard let model = viewModel.dataModel else { fatalError("ONBOARDING MODEL WAS NOT FOUND") }
        onboardingDataModel = model
    }
    
    var body: some View {
        GeometryReader { geometryProxy in
            VStack(spacing: 20) {
                Spacer()
                imageView(with: geometryProxy,
                          imageName: onboardingDataModel.imageName)
                .padding(.bottom)
                
                titleAndDescriptionView(title: onboardingDataModel.title,
                                        description: onboardingDataModel.description)
                Spacer()

            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
           
            .safeAreaInset(edge: .bottom) {
                buttonView(buttonText: onboardingDataModel.buttonText,
                           action: intents.onboardingButtonAction)
            }
        }
    }
}

@ViewBuilder
private func imageView(with proxy: GeometryProxy, imageName: String) -> some View {
    Image(imageName)
        .resizable()
        .scaledToFit()
        .frame(width: proxy.size.width * 0.4,
               height: proxy.size.height * 0.4)
}

@ViewBuilder
private func titleAndDescriptionView(title: String, description: String) -> some View {
    Text(title)
        .font(.title)
        .frame(alignment: .leading)
        .bold()
    
    Text(description)
        .frame(alignment: .leading)
        .font(.body)
}



@ViewBuilder
private func buttonView(buttonText: String, action: @escaping () -> Void) -> some View {
    HStack(spacing: 30) {
        Button {
            action()
        } label: {
            HStack {
                Text("Lets go")
                Image(systemName: "chevron.right")
            }
            .foregroundStyle(.white)
        }
        .padding()
        .background(Color.darkCharcoal)
        .clipShape(Capsule())
        
        Spacer()
    }
    .padding(.horizontal)
}

#Preview {
    OnboardingView(viewModel: AccountOnboardingViewModel(), intents: InitialOnboardingIntents())
}
