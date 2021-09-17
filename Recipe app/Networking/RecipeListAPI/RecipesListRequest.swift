//
//  RecipesListRequest.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 16.09.21.
//

import Foundation

struct RecipesListRequest: RequestType {
    typealias Response = [Recipe]
    
    var pathString: String = URLRepository.recipesPath
    var httpMethod: HTTPMethod = .get
    var pathQuery: String = ""
    var body: Data? = nil
}
