import SwiftUI
import FictionalInjection

struct OnboardingView: View {
    let imageName: String
    let title: String
    let description: String
    
    init(imageName: String, title: String, description: String) {
        self.imageName = imageName
        self.title = title
        self.description = description
    }
    
    var body: some View {
        GeometryReader { geometryProxy in
            VStack(spacing: 20) {
                Spacer()
                imageView(with: geometryProxy,
                          imageName: imageName)
                .padding(.bottom)
                
                titleAndDescriptionView(title: title,
                                        description: description)
                Spacer()
                
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

@ViewBuilder
private func imageView(with proxy: GeometryProxy, imageName: String) -> some View {
    Image(imageName)
        .resizable()
        .scaledToFill()
        .frame(width: proxy.size.width * 0.3,
               height: proxy.size.height * 0.3)
}

@ViewBuilder
private func titleAndDescriptionView(title: String, description: String) -> some View {
    HStack {
        Text(title)
            .font(.title)
            .frame(alignment: .leading)
            .bold()
        Spacer()
    }
    
    Text(description)
        .frame(alignment: .leading)
        .font(.body)
}
