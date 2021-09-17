//
//  RecipeView.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 17.09.21.
//

import SwiftUI
import Combine

struct RecipeView<ViewModel: RecipeViewModelType>: View {
    @ObservedObject var viewModel: ViewModel
    
    @State var isEditing: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                recipeImage
                    .padding(.horizontal)
                Text(viewModel.recipe.title)
                    .titleStyle()
                Text(viewModel.recipe.description)
                    .multilineTextAlignment(.center)
                    .descriptionStyle()
                ingredients
                instructions
                linkToURL
            }
        }
        .navigationBarItems(trailing: editButton)
        .padding()
        .onAppear {
            viewModel.fetchImageIfNeeded()
        }
        .sheet(isPresented: $isEditing) {
            RecipeActionView(
                viewModel: RecipeEditActionViewModel(recipe: viewModel.recipe),
                isPresented: $isEditing
            )
        }
    }
    
    @ViewBuilder
    var instructions: some View {
        VStack(alignment: .leading) {
            Text("Instructions")
                .font(.title)
                .padding()
            Text(viewModel.recipe.instructions)
                .multilineTextAlignment(.leading)
                .descriptionStyle()
        }
        .fixedSize(horizontal: false, vertical: true)
    }
    
    @ViewBuilder
    var ingredients: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Ingredients")
                    .font(.title)
                    .padding()
                ForEach(viewModel.recipe.ingredients, id: \.self) { ingredient in
                    IngredientListView(ingredient: ingredient)
                }
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    var recipeImage: some View {
        if viewModel.recipe.imageUrl != nil {
            RecipeImage(image: $viewModel.recipeImage)
        }
    }
    
    @ViewBuilder
    var linkToURL: some View {
        if let url = URL(string: viewModel.recipe.sourceUrl ?? "") {
            HStack {
                Spacer()
                Link(destination: url) {
                    Group {
                        Text("Open in browser")
                        Image(systemName: "arrowshape.turn.up.right.fill")
                    }
                    .foregroundColor(Color(.systemBlue))
                }
            }
        }
    }
    
    var editButton: some View {
        Button(action: {
            isEditing.toggle()
        }, label: {
            Text("Edit")
        })
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(viewModel: RecipeViewModel(recipe: .mock))
    }
}
