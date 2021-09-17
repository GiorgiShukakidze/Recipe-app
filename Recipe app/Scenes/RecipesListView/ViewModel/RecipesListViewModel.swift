//
//  RecipesListViewModel.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 17.09.21.
//

import SwiftUI
import Combine

class RecipesListViewModel: ObservableObject, RecipesListViewModelType {
    typealias RecipeListService = RecipesListAPI
    
    @Published private(set) var recipes: [Recipe] = []
    @Published var state: ViewModelState = .idle
        
    private var cancellables: Set<AnyCancellable> = []
 
    private let service: RecipeListService
            
    required init(service: RecipeListService = RecipesListAPI()) {
        self.service = service
        
        setup()
    }
    
    //MARK: - User intents
    func fetchRecipes() {
        state = .loading
        
        service.fetchList()
            .sink {[weak self] completion in
                if case .failure(let error) = completion {
                    self?.state = .error(error.errorDescription ?? "")
                }
            } receiveValue: {[weak self] recipes in
                self?.handleNewData(recipes)
            }
            .store(in: &cancellables)
    }
    
    func delete(at indexSet: IndexSet) {
        let idsToDelete = indexSet.map {[weak self] in self?.recipes[$0].id }
        let publishers = Publishers.MergeMany(idsToDelete.compactMap { $0 }.map { service.deleteRecipe($0) }).eraseToAnyPublisher()

        recipes.remove(atOffsets: indexSet)

        state = .loading

        publishers.sink {[weak self] completion in
            switch completion {
            case .finished: self?.state = .complete
            case .failure(let error):
                self?.state = .error(error.errorDescription ?? "")
                self?.refresh()
            }
        } receiveValue: { [weak self] id in
            self?.state = .complete
        }
        .store(in: &cancellables)
    }
    
    func refresh() {
        reset()
        fetchRecipes()
    }
    
    private func setup() {
        NotificationCenter.default.publisher(for: .RecipeUpdated)
            .sink {[weak self] _ in
                self?.refresh()
            }
            .store(in: &cancellables)
    }
    
    private func handleNewData(_ recipesList: [Recipe]) {
        state = recipesList.isEmpty ? .empty : .complete
        recipes = recipesList
    }
    
    private func reset() {
        recipes = []
        state = .idle
    }
}
