//
//  ContentView.swift
//  Recipe app
//
//  Created by Giorgi Shukakidze on 16.09.21.
//

import SwiftUI
import Combine

struct RecipesListView<ViewModel: RecipesListViewModelType>: View {
    @ObservedObject var viewModel: ViewModel
    
    @State private var isLoading: Bool = false
    @State private var alertToShow: IdentifiableAlert?
    @State private var isAdding: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        ForEach(viewModel.recipes, id: \.id) { recipe in
                            RecipeListRowView(viewModel: RecipeListRowViewModel(recipe))
                        }
                        .onDelete{ viewModel.delete(at: $0) }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
                
                stateView
            }
            .navigationBarTitle("Recipes")
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: addButton)
        }
        .onChange(of: viewModel.state) { handleStateChange($0) }
        .overlay(LoadingOverlay(show: $isLoading))
        .onAppear {
            setupNavigationBar()
            viewModel.fetchRecipes()
        }
        .alert(item: $alertToShow) { $0.alert() }
        .sheet(isPresented: $isAdding) {
            RecipeActionView(
                viewModel: RecipeAddActionViewModel(),
                isPresented: $isAdding
            )
        }
    }
    
    @ViewBuilder
    var stateView: some View {
        switch viewModel.state {
        case .loading:
            ProgressView().scaleEffect(2)
        case .empty:
            Text("No items to show...")
        default:
            EmptyView()
        }
    }
    
    var addButton: some View {
        Button(action: {
            isAdding.toggle()
        }, label: {
            Image(systemName: "plus")
        })
    }
    
    private func handleStateChange(_ state: ViewModelState) {
        isLoading = state == .loading
        
        switch state {
        case .error(let message):
            alertToShow = .init(title: "Fetching recipes failed", message: message)
        default:
            break
        }
    }
    
    private func setupNavigationBar() {
        let color = UIColor.orange
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: color]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: color]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesListView(viewModel: RecipesListViewModel())
    }
}
