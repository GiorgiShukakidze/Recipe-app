//
//  NetworkingServiceType.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 16.09.21.
//

import Foundation
import Combine

protocol NetworkingServiceType {
    func dataRequest<Request: RequestType>(from request: Request) -> AnyPublisher<Request.Response, RecipeAppError>
    func deleteRequest<Request: RequestType>(from request: Request) -> AnyPublisher<Void, RecipeAppError>
}
