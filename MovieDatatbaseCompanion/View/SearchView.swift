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

    
    // MARK: - Lifecycle
    
    var body: some View {
        Picker("", selection: $viewModel.searchType) {
            Text(SearchViewModel.SearchType.movies.rawValue)
            Text(SearchViewModel.SearchType.series.rawValue)
        }
        .pickerStyle(.segmented)

        ScrollView {
            LazyVStack(spacing: 16) {
                switch viewModel.state {
                case .initial:
                    Text("Search for movies or series.")
                case .loading:
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(3.0)
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
