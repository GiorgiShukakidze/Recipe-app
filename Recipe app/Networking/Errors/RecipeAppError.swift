//
//  RecipeAppError.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 16.09.21.
//

import Foundation

enum RecipeAppError: Error, Equatable {
    case invalidURL
    case badRequest(String)
    case unauthorized
    case other(String)
    case parseError(String)
    
    var message: String {
        ///Can be switched over self and return explicit message per error.
        "Oops.. Something went wrong. Please try again."
    }
}

extension RecipeAppError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badRequest(let text): return NSLocalizedString("\(text)", comment: "")
        case .invalidURL:
            return NSLocalizedString("Invalid URL is provided", comment: "")
        case .unauthorized:
            return NSLocalizedString("Request is unauthorized", comment: "")
        case .other(let description):
            return NSLocalizedString("\(description)", comment: "")
        case .parseError(let description):
            return NSLocalizedString("Error parsing data \(description)", comment: "")
        }
    }
}
