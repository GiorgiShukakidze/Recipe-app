//
//  Extensions.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 17.09.21.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension Image {
    func recipeImageStyle(size: CGSize) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(Color(.lightGray))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

extension Notification.Name {
    static let RecipeUpdated = Notification.Name("recipe_updated")
}
