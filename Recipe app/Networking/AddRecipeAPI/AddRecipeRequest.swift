//
//  AddRecipeRequest.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 17.09.21.
//

import Foundation

struct AddRecipeRequest: RequestType {
    typealias Response = Recipe
    
    var pathString: String = URLRepository.recipesPath
    var httpMethod: HTTPMethod = .post
    var pathQuery: String = ""
    var body: Data? = nil
}
