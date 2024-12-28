import SwiftUI
import PhotosUI

struct CreateAccountView: View {
    @FocusState var focusField: FocusedField?
    
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: Image = Image("account-image")
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var username: String = ""
    @State var bio: String = ""
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            selectedImage
                .resizable()
                .frame(width: 200, height: 200)
                .clipShape(Circle())
            PhotosPicker("Select a picture", selection: $pickerItem, matching: .images)
            
            createTextField(fieldType: .singleLine,
                            fieldTitle: "first name",
                            text: $firstName,
                            promptText: "enter first name",
                            focusState: .firstname,
                            actionButtonLabel: .next)
            
            
            Spacer()
        }
        .onChange(of: pickerItem) {
            Task {
                selectedImage = try await pickerItem?.loadTransferable(type: Image.self) ?? Image("account-image")
            }
        }
        .ignoresSafeArea(.keyboard)
        .safeAreaInset(edge: .bottom, content: {
            createButton(buttonText: "Save") {
                //action
            }
        })
        .padding()
        .onSubmit {
            switch focusField {
            case .firstname:
                focusField = .lastname
            case .lastname:
                focusField = .username
            case .username:
                focusField = .bio
            case .bio, .none:
                focusField = nil
            }
        }
    }
    
    @ViewBuilder
    private func createTextField(fieldType: FieldType,
                                 fieldTitle: String,
                                 text: Binding<String>,
                                 promptText: String,
                                 focusState: FocusedField,
                                 actionButtonLabel: SubmitLabel) -> some View {
        VStack {
            HStack {
                Text(fieldTitle)
                    .font(.caption)
                    .bold()
                Spacer()
            }
            
            switch fieldType {
            case .singleLine:
                TextField("",
                          text: text,
                          prompt: Text(promptText))
                .textFieldStyle(.roundedBorder)
                .focused($focusField, equals: focusState)
                .submitLabel(actionButtonLabel)
            case .verticalField:
                TextField("",
                          text: text,
                          prompt:Text(promptText),
                          axis: .vertical)
                .lineLimit(5, reservesSpace: true)
                .textFieldStyle(.roundedBorder)
                .focused($focusField, equals: focusState)
                .submitLabel(actionButtonLabel)
                .lineLimit(5, reservesSpace: true)
            }
        }
    }

    @ViewBuilder
    private func createButton(buttonText: String, buttonAction: @escaping () -> Void) -> some View {
        Button {
            buttonAction()
        } label: {
            HStack {
                Text(buttonText)
            }
            .foregroundStyle(.white)
        }
        .padding()
        .background(Color.darkCharcoal)
        .clipShape(Capsule())
        .ignoresSafeArea(.keyboard)
    }
}
