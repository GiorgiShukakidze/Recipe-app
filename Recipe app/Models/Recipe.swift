//
//  Recipe.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 16.09.21.
//

import Foundation

struct Recipe: Codable, Identifiable, Equatable {
    let id: String
    let title: String
    let description: String
    let ingredients: [String]
    let instructions: String
    let imageUrl: String?
    let sourceUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, ingredients, instructions, imageUrl, sourceUrl
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(ingredients, forKey: .ingredients)
        try container.encode(instructions, forKey: .instructions)
        try container.encode(imageUrl, forKey: .imageUrl)
        try container.encode(sourceUrl, forKey: .sourceUrl)
    }
}

extension Recipe {
    static let mock = Recipe(
        id: "1",
        title: "Mock Recipe",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        ingredients: ["A ingredient", "B ingredient", "C ingredient"],
        instructions: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        imageUrl: nil,
        sourceUrl: nil
    )
}
