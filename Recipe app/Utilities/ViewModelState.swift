//
//  ViewModelState.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 17.09.21.
//

import Foundation

enum ViewModelState: Equatable {
    case idle
    case loading
    case complete
    case empty
    case error(String)
}
