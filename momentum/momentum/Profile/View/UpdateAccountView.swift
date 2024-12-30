import SwiftUI
import PhotosUI

struct UpdateAccountView: View {
    @FocusState var focusField: FocusedField?
    @State private var pickerItem: PhotosPickerItem?
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: UpdateAccountViewModel
    private var intents: UpdateAccountIntentProtocol
    
    init(viewModel: UpdateAccountViewModel, intents: UpdateAccountIntentProtocol) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.intents = intents
    }
    
    var body: some View {
        
        VStack(spacing: 30) {
            Text("Set up your account")
                .font(.title)
                .bold()
            ScrollView {
                viewModel.selectedImage
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                PhotosPicker("Select a picture", selection: $pickerItem, matching: .images)
                
                ForEach(viewModel.dataModel?.textFields ?? [], id: \.fieldTitle) { field in
                    createTextField(fieldType: field.fieldType,
                                    fieldTitle: field.fieldTitle,
                                    text: field.text,
                                    promptText: field.promptText,
                                    focusState: field.focusedState,
                                    actionButtonLabel: field.actionButtonLabel)
                }
            }  .scrollIndicators(.hidden)
        }
        .onChange(of: pickerItem) {
            Task {
                viewModel.selectedImage = try await pickerItem?.loadTransferable(type: Image.self) ?? Image("account-image")
            }
        }
        .ignoresSafeArea(.keyboard)
        .safeAreaInset(edge: .bottom, content: {
            createButton(buttonText: "Save") {
                intents.saveUserContext(firstName: viewModel.firstName,
                                        lastName: viewModel.lastName,
                                        username: viewModel.username,
                                        bio: viewModel.bio)
                dismiss()
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
            case .multiLine:
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
