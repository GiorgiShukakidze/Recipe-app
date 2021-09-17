//
//  RecipesListAPIType.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 16.09.21.
//

import Foundation
import Combine

protocol RecipesListAPIType: ServiceAPIType {
    func fetchList() -> AnyPublisher<Request.Response, RecipeAppError>
    func deleteRecipe(_ id: String) -> AnyPublisher<String, RecipeAppError>
}

//MARK: - Default Implementation
extension RecipesListAPIType {
    func fetchList() -> AnyPublisher<Request.Response, RecipeAppError> {
        request.httpMethod = .get
        request.pathQuery = ""

        return serviceManager.dataRequest(from: request)
    }
    
    
    func deleteRecipe(_ id: String) -> AnyPublisher<String, RecipeAppError> {
        request.httpMethod = .delete
        request.pathQuery = id
        
        return serviceManager.deleteRequest(from: request)
            .map{ _ in id }
            .eraseToAnyPublisher()
    }
}
