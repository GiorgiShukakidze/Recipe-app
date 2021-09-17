//
//  RecipeAddActionViewModel.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 17.09.21.
//

import Foundation
import SwiftUI
import Combine

class RecipeAddActionViewModel: RecipeActionViewModelType, ObservableObject {
    @Published var state: ViewModelState = .idle
    @Published var recipe: Recipe?
    
    var onFinish = PassthroughSubject<Void, Never>()
    var scope: ActionScope = .add

    private let service: AddRecipeAPI
    private var cancellables: Set<AnyCancellable> = []

    init(service: AddRecipeAPI = AddRecipeAPI()) {
        self.service = service
    }
    
    func performAction(for recipe: Recipe) {
        self.recipe = recipe
        
        state = .loading
        
        service.addRecipe(recipe)
            .sink {[weak self] comp in
                if case .failure(let error) = comp {
                    self?.state = .error(error.message)
                }
            } receiveValue: {[weak self] recipe in
                print("Recipe added: ", recipe)
                self?.state = .complete
                self?.onFinish.send(())
            }
            .store(in: &cancellables)
    }
}
