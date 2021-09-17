//
//  EditRecipeRequest.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 17.09.21.
//

import Foundation

struct EditRecipeRequest: RequestType {
    typealias Response = Recipe
    
    var pathString: String = URLRepository.recipesPath
    var httpMethod: HTTPMethod = .put
    var pathQuery: String = ""
    var body: Data? = nil
}
