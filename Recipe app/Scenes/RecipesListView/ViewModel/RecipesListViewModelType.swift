//
//  RecipesListViewModelType.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 17.09.21.
//

import Foundation

protocol RecipesListViewModelType: ObservableObject {
    associatedtype RecipeListService: RecipesListAPIType

    var recipes: [Recipe] { get }
    var state: ViewModelState { get }
    
    init(service: RecipeListService)
    
    func fetchRecipes()
    func refresh()
    func delete(at indexSet: IndexSet)
}
