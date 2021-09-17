//
//  NetworkManager.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 16.09.21.
//

import Foundation
import Combine

class NetworkManager: NetworkingServiceType {
    static let shared = NetworkManager()
    
    private let baseURL: URL? = URL(string: URLRepository.baseURL)
    private let defaultHeaderItems = ["Content-Type": "Application/json"]

    private var cancellables = Set<AnyCancellable>()
    
    func dataRequest<Request: RequestType>(from request: Request) -> AnyPublisher<Request.Response, RecipeAppError> {
        guard var urlRequest = request.request() else {
            return Fail(error: request.mapError(NetworkError.invalidRequest)).eraseToAnyPublisher()
        }
        
        defaultHeaderItems.forEach {
            urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        return fetchResponse(for: urlRequest)
            .decode(type: Request.Response.self, decoder: request.decoder)
            .mapError(request.mapError(_:))
            .eraseToAnyPublisher()
    }
    
    func deleteRequest<Request: RequestType>(from request: Request) -> AnyPublisher<Void, RecipeAppError> {
        guard let urlRequest = request.request() else {
            return Fail(error: request.mapError(NetworkError.invalidRequest)).eraseToAnyPublisher()
        }

        return fetchResponse(for: urlRequest)
            .map {_ in () }
            .mapError(request.mapError(_:))
            .eraseToAnyPublisher()
    }
    
    private func fetchResponse(for request: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: RunLoop.main)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      200 == httpResponse.statusCode else {
                    let responseCode = (response as? HTTPURLResponse)?.statusCode ?? -1

                    switch responseCode {
                    case -1:
                        throw NetworkError.other("Invalid response")
                    case 400...499:
                        throw NetworkError.internalError(responseCode, data)
                    default:
                        throw NetworkError.serverError
                    }
                }

                return data
            }
            .eraseToAnyPublisher()
    }
}
