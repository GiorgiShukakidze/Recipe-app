//
//  AddRecipeAPI.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 17.09.21.
//

import Foundation

class AddRecipeAPI: AddRecipeAPIType {
    typealias Request = AddRecipeRequest
    
    private(set) var serviceManager: NetworkingServiceType
    var request = AddRecipeRequest()

    
    init(serviceManager: NetworkingServiceType = NetworkManager.shared) {
        self.serviceManager = serviceManager
    }
}
