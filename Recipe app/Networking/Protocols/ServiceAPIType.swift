//
//  ServiceAPIType.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 16.09.21.
//

import Foundation
import Combine

protocol ServiceAPIType: AnyObject {
    associatedtype Request: RequestType
    
    var serviceManager: NetworkingServiceType { get }
    var request: Request { get set }
}
