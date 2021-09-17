//
//  RecipeListRowViewModelType.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 17.09.21.
//

import Foundation
import SwiftUI

protocol RecipeListRowViewModelType: ObservableObject {
    var recipe: Recipe { get }
    var recipeImage: UIImage? { get set }
    
    func getImage()
}
