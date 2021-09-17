//
//  Recipe_appApp.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 16.09.21.
//

import SwiftUI

@main
struct Recipe_appApp: App {
    var body: some Scene {
        WindowGroup {
            RecipesListView(viewModel: RecipesListViewModel())
        }
    }
}
