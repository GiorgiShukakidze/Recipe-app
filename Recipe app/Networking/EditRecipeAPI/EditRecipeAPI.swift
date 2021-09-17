//
//  EditRecipeAPI.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 17.09.21.
//

import Foundation

class EditRecipeAPI: EditRecipeAPIType {
    typealias Request = EditRecipeRequest
    
    private(set) var serviceManager: NetworkingServiceType
    var request = EditRecipeRequest()

    
    init(serviceManager: NetworkingServiceType = NetworkManager.shared) {
        self.serviceManager = serviceManager
    }
}
