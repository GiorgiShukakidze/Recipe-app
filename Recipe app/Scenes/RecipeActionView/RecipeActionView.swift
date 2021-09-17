//
//  RecipeActionView.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 17.09.21.
//

import SwiftUI
import Combine

struct RecipeActionView<ViewModel: RecipeActionViewModelType>: View {
    @ObservedObject var viewModel: ViewModel
    @Binding var isPresented: Bool
    
    @State private var isLoading: Bool = false
    @State private var alertToShow: IdentifiableAlert?
    
    @State var titleText: String = ""
    @State var descriptionText: String = ""
    @State var ingredientsText: String = ""
    @State var instructionsText: String = ""
    @State var imageUrlText: String = ""
    @State var sourceUrlText: String = ""
        
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {
                    Text(viewModel.scope.rawValue)
                        .font(.largeTitle)
                        .padding()
                    TextView(title: "Recipe Title", text: $titleText)
                    TextView(title: "Recipe description", text: $descriptionText)
                    TextView(title: "Recipe ingredients (separated by \";\")", text: $ingredientsText)
                    TextView(title: "Recipe instructions", text: $instructionsText)
                    TextView(title: "Recipe image url", text: $imageUrlText)
                    TextView(title: "Recipe source url", text: $sourceUrlText)
                    Spacer()
                    submitButton
                }
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
            }
            
            stateView
        }
        .onChange(of: viewModel.state) { handleStateChange($0) }
        .overlay(LoadingOverlay(show: $isLoading))
        .alert(item: $alertToShow) { $0.alert() }
        .onTapGesture { hideKeyboard() }
        .onAppear { bindToOutputs() }
    }
    
    @ViewBuilder
    var stateView: some View {
        switch viewModel.state {
        case .loading:
            ProgressView().scaleEffect(2)
        default:
            EmptyView()
        }
    }
    
    var submitButton: some View {
        Button(action: {
            performAction()
        }, label: {
            Text("Submit")
                .bold()
                .foregroundColor(.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(.blue)
                        .frame(width: UIScreen.screenWidth * 0.5)
                )
        })
    }
    
    private func handleStateChange(_ state: ViewModelState) {
        isLoading = state == .loading
        
        switch state {
        case .error(let message):
            alertToShow = .init(title: "Updating recipe failed", message: message)
        default:
            break
        }
    }
    
    private func performAction() {
        hideKeyboard()
        
        let ingredients = ingredientsText.components(separatedBy: ";").filter{ !$0.isEmpty }
        
        guard !ingredients.isEmpty, !titleText.isEmpty, !descriptionText.isEmpty, !instructionsText.isEmpty else {
            alertToShow = .init(
                title: "Empty field found!",
                message: "Title, Description, Instructions or Ingredients should not be empty!"
            )
            
            return
        }
        
        let recipe = Recipe(
            id: viewModel.recipe?.id ?? "",
            title: titleText,
            description: descriptionText,
            ingredients: ingredients,
            instructions: instructionsText,
            imageUrl: imageUrlText,
            sourceUrl: sourceUrlText
        )
        
        viewModel.performAction(for: recipe)
    }
    
    @State var cancellables: Set<AnyCancellable> = []

    private func bindToOutputs() {
        viewModel.onFinish
            .sink { _ in
                NotificationCenter.default.post(name: .RecipeUpdated, object: viewModel.recipe)
                isPresented = false
            }
            .store(in: &cancellables)
        
        titleText = viewModel.recipe?.title ?? ""
        descriptionText =  viewModel.recipe?.description ?? ""
        ingredientsText = viewModel.recipe?.ingredients.joined(separator: " ") ?? ""
        instructionsText = viewModel.recipe?.instructions ?? ""
        imageUrlText = viewModel.recipe?.imageUrl ?? ""
        sourceUrlText = viewModel.recipe?.sourceUrl ?? ""
    }
}

struct RecipeActionView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeActionView(viewModel: RecipeAddActionViewModel(), isPresented: .constant(true))
    }
}
