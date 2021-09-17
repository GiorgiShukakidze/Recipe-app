//
//  RequestType.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 16.09.21.
//

import Foundation

protocol RequestType {
    associatedtype Response: Codable
    
    var baseURLString: String { get }
    var pathString: String { get }

    var headerParameters: [String : String] { get }
    
    var queryItems: [URLQueryItem] { get }
    var pathQuery: String { get set }
    var body: Data? { get set }
    
    var httpMethod: HTTPMethod { get set }

    var decoder: JSONDecoder { get }
    var encoder: JSONEncoder { get }
    
    func request() -> URLRequest?
    func mapError(_ error: Error) -> RecipeAppError
}

//MARK: - Default Implementation
extension RequestType {
    var baseURLString: String { URLRepository.baseURL }
    var headerParameters: [String : String] { [:] }
    var queryItems: [URLQueryItem] { [] }
    var decoder: JSONDecoder { JSONDecoder() }
    var encoder: JSONEncoder { JSONEncoder() }

    func request() -> URLRequest? {
        let baseURL = URL(string: baseURLString)
        guard let fullURL = URL(string: pathString + "/" + pathQuery, relativeTo: baseURL) else { return nil }
        
        var components = URLComponents(url: fullURL, resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems
        
        if let url = components?.url {
            var urlRequest = URLRequest(url: url)
            
            for (key, value) in headerParameters {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
            
            urlRequest.httpBody = body
            urlRequest.httpMethod = httpMethod.rawValue
            
            return urlRequest
        }
        
        return nil
    }
    
    func mapError(_ error: Error) -> RecipeAppError {
        if let networkError = error as? NetworkError {
            return mapNetworkError(networkError)
        }
        
        if let decodeError = error as? DecodingError {
            return .parseError(decodeError.localizedDescription)
        }
        
        return RecipeAppError.other(error.localizedDescription)
    }
    
    private func mapNetworkError(_ error: NetworkError) -> RecipeAppError {
        switch error {
        case .internalError(let code, _):
            switch code {
            case 400: return .badRequest(error.localizedDescription)
            case 401: return .unauthorized
            default: return .other(error.localizedDescription)
            }
        case .serverError: return .other(error.localizedDescription)
        case .invalidRequest: return .invalidURL
        case .other(let description): return .other(description)
        }
    }
}
