//
//  ViewModifiers.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 17.09.21.
//

import Foundation
import SwiftUI

struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .font(.callout.bold())
            .foregroundColor(Color(.orange))
    }
}

struct DescriptionStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .foregroundColor(Color(.darkGray))
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(TitleStyle())
    }
    
    func descriptionStyle() -> some View {
        self.modifier(DescriptionStyle())
    }
}
