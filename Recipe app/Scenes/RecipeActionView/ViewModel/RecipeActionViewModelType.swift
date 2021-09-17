//
//  RecipeActionViewModelType.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 17.09.21.
//

import Foundation
import SwiftUI
import Combine

protocol RecipeActionViewModelType: ObservableObject {
    var state: ViewModelState { get }
    var recipe: Recipe? { get set }
    var scope: ActionScope { get }
    var onFinish: PassthroughSubject<Void, Never> { get }

    func performAction(for recipe: Recipe)
}

enum ActionScope: String {
    case add = "Add Recipe"
    case edit = "Edit Recipe"
}
