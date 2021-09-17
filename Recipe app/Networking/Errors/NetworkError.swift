//
//  NetworkError.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 16.09.21.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case internalError(Int, Data)
    case serverError
    case other(String)
}
