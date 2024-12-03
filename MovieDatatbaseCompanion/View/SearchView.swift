//
//  SearchView.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 30/11/24.
//

import SwiftUI


// MARK: - MovieDatatbaseCompanionApp -

struct SearchView: View {
    
    
    // MARK: - Properties

    @StateObject var viewModel = SearchViewModel()
    
    let pickerOptions = [SearchViewModel.SearchType.movies.description,
                         SearchViewModel.SearchType.series.description]

    
    // MARK: - Lifecycle
    
    var body: some View {
        Picker("", selection: $viewModel.searchType) {
            ForEach(pickerOptions, id: \.self) {
                Text($0)
            }
        }
        .pickerStyle(.segmented)
        .tint(.brandPrimary)
        .padding(.itemSpace)

        ScrollView {
            LazyVStack(spacing: .itemSpace) {
                switch viewModel.state {
                case .initial:
                    Text("Search for \(viewModel.searchType.description).")
                        .padding(.contentSpace)
                case .loading:
                    LoadingView()
                case .movieResults(let items):
                    ForEach(items, id: \.self) { movie in
                        MovieView(movie: movie)
                    }
                case .seriesResults(let items):
                    ForEach(items, id: \.self) { series in
                        Text(series.name)
                    }
                case .noResults:
                    Text("No results. Try different search input.")
                        .padding(.contentSpace)
                }
            }
        }
        .searchable(text: $viewModel.searchText)
    }
}


// MARK: - Preview -

#Preview {
    SearchView()
}
