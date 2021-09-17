//
//  SupportingViews.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 17.09.21.
//

import Foundation
import SwiftUI

struct RecipeImage: View {
    @Binding var image: UIImage?
    
    var body: some View {
        if image == nil {
            let placeholder = UIImage(named: "placeholder")
            Image(uiImage: placeholder ?? UIImage())
                .recipeImageStyle(size: placeholder?.size ?? .zero)
        }
        if let uiImage = image {
            Image(uiImage: uiImage)
                .recipeImageStyle(size: image?.size ?? .zero)
        }
    }
}

struct LoadingMoreCell: View {
    var body: some View {
        HStack {
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .orange))
            Spacer()
        }
    }
}

struct LoadingOverlay: View {
    @Binding var show: Bool
    
    var body: some View {
        if show {
            Color(.gray)
                .opacity(0.5)
                .ignoresSafeArea()
        }
    }
}

struct IdentifiableAlert: Identifiable {
    var id: String
    var alert: () -> Alert
    
    init(title: String, message: String) {
        self.id = title + message
        alert = { Alert(title: Text(title), message: Text(message), dismissButton: .default(Text("OK"))) }
    }
}

struct IngredientListView: View {
    @State var ingredient: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(ingredient)
                .padding(.top)
            Color(.lightGray)
                .frame(width: UIScreen.screenWidth * 0.7, height: 1, alignment: .leading)
        }
    }
}

struct TextView: View {
    @State var title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\(title):")
                .bold()
            TextEditor(text: $text)
                .border(Color.orange)
                .frame(minHeight: 120)
        }
    }
}

