//
//  RecipeEditActionViewModel.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 17.09.21.
//

import Foundation
import SwiftUI
import Combine

class RecipeEditActionViewModel: RecipeActionViewModelType, ObservableObject {
    @Published var state: ViewModelState = .idle
    @Published var recipe: Recipe?
    
    var onFinish = PassthroughSubject<Void, Never>()
    var scope: ActionScope = .edit

    private let service: EditRecipeAPI
    private var cancellables: Set<AnyCancellable> = []

    init(service: EditRecipeAPI = EditRecipeAPI(), recipe: Recipe) {
        self.service = service
        self.recipe = recipe
    }
    
    func performAction(for recipe: Recipe) {
        state = .loading
        
        service.editRecipe(recipe.id, updated: recipe)
            .sink {[weak self] comp in
                if case .failure(let error) = comp {
                    self?.state = .error(error.message)
                }
            } receiveValue: {[weak self] recipe in
                print("Recipe edited: ", recipe)
                self?.recipe = recipe
                self?.state = .complete
                self?.onFinish.send(())
            }
            .store(in: &cancellables)
    }
}
