//
//  RecipeListRowViewModel.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 17.09.21.
//

import Foundation
import SwiftUI
import Combine

class RecipeListRowViewModel: ObservableObject, RecipeListRowViewModelType {
    @Published var recipe: Recipe
    @Published var recipeImage: UIImage?
    
    private let imageDownloader = ImageDownloader()
    
    init(_ recipe: Recipe) {
        self.recipe = recipe
    }
    
    func getImage() {
        imageDownloader.imagePublisher(for: recipe.imageUrl ?? "")
            .assign(to: &$recipeImage)
    }
}
