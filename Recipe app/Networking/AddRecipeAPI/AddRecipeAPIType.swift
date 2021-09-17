//
//  AddRecipeAPIType.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 17.09.21.
//

import Foundation
import Combine

protocol AddRecipeAPIType: ServiceAPIType {
    func addRecipe(_ recipe: Recipe) -> AnyPublisher<Request.Response, RecipeAppError>
}

//MARK: - Default Implementation
extension AddRecipeAPIType {
    func addRecipe(_ recipe: Recipe) -> AnyPublisher<Request.Response, RecipeAppError> {
        request.body = try? request.encoder.encode(recipe)
        
        return serviceManager.dataRequest(from: request)
    }
}
