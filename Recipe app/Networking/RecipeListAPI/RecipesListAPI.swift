//
//  RecipesListAPI.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 16.09.21.
//

import Foundation

class RecipesListAPI: RecipesListAPIType {
    typealias Request = RecipesListRequest
    
    private(set) var serviceManager: NetworkingServiceType
    var request = RecipesListRequest()

    
    init(serviceManager: NetworkingServiceType = NetworkManager.shared) {
        self.serviceManager = serviceManager
    }
}
