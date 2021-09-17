//
//  RecipleListRowView.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 17.09.21.
//

import SwiftUI

struct RecipeListRowView<ViewModel: RecipeListRowViewModelType>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationLink(
            destination: RecipeView(viewModel: RecipeViewModel(recipe: viewModel.recipe))
        ) {
            VStack(alignment: .leading, spacing: 15) {
                recipeImage
                Text(viewModel.recipe.title)
                    .titleStyle()
            }
        }
        .isDetailLink(false)
    }
    
    @ViewBuilder
    var recipeImage: some View {
        if viewModel.recipe.imageUrl != nil {
            RecipeImage(image: $viewModel.recipeImage)
                .onAppear { viewModel.getImage() }
        }
    }
}

struct RecipleListRowView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListRowView(viewModel: RecipeListRowViewModel(.mock))
    }
}
