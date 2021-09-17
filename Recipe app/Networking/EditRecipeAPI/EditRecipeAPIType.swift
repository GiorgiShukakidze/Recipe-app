//
//  EditRecipeAPIType.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 17.09.21.
//

import Foundation
import Combine

protocol EditRecipeAPIType: ServiceAPIType {
    func editRecipe(_ id: String, updated recipe: Recipe) -> AnyPublisher<Request.Response, RecipeAppError>
}

//MARK: - Default Implementation
extension EditRecipeAPIType {
    func editRecipe(_ id: String, updated recipe: Recipe) -> AnyPublisher<Request.Response, RecipeAppError> {
        request.body = try? request.encoder.encode(recipe)
        request.pathQuery = id
        
        return serviceManager.dataRequest(from: request)
    }
}
