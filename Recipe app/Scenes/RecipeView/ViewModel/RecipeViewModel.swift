//
//  RecipeViewModel.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 17.09.21.
//

import Foundation
import SwiftUI
import Combine

class RecipeViewModel: ObservableObject, RecipeViewModelType {
    typealias EditRecipeService = EditRecipeAPI

    @Published var recipe: Recipe
    @Published var recipeImage: UIImage?
    @Published var state: ViewModelState = .complete
    
    private let imageDownloader = ImageDownloader()
    private var cancellables = Set<AnyCancellable>()

    required init(recipe: Recipe) {
        self.recipe = recipe
        setup()
    }
    
    func fetchImageIfNeeded() {
        imageDownloader.imagePublisher(for: recipe.imageUrl ?? "")
            .assign(to: &$recipeImage)
    }
    
    func update(with recipe: Recipe) {
        self.recipe = recipe
        fetchImageIfNeeded()
    }
    
    private func setup() {
        NotificationCenter.default.publisher(for: .RecipeUpdated)
            .compactMap {$0.object as? Recipe}
            .sink {[weak self] recipe in
                self?.update(with: recipe)
            }
            .store(in: &cancellables)
    }
}
