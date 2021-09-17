//
//  RecipeViewModelType.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 17.09.21.
//

import Foundation
import SwiftUI

protocol RecipeViewModelType: ObservableObject {
    var recipe: Recipe { get }
    var recipeImage: UIImage? { get set }
    var state: ViewModelState { get }
        
    func fetchImageIfNeeded()
    func update(with recipe: Recipe)
}
