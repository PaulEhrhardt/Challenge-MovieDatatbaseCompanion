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
    let columns = [GridItem(.adaptive(minimum: 300))]

    
    // MARK: - Lifecycle
    
    var body: some View {
        VStack(spacing: .itemSpace) {
            Picker("", selection: $viewModel.searchType) {
                ForEach(pickerOptions, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            .padding(.itemSpace)
            .onChange(of: viewModel.searchType) { _, _ in
                viewModel.setState(.initial)
            }

            ScrollView {
                LazyVGrid(columns: columns, spacing: .bigSpace) {
                    switch viewModel.state {
                    case .initial:
                        Text("Search for \(viewModel.searchType.description).")
                            .foregroundColor(Color(uiColor: .tertiaryLabel))
                            .padding(.contentSpace)
                    case .loading:
                        LoadingView()
                    case .movieResults(let items):
                        ForEach(items, id: \.self) { movie in
                            FilmView(item: movie.asFilmItem())
                        }
                    case .seriesResults(let items):
                        ForEach(items, id: \.self) { series in
                            FilmView(item: series.asFilmItem())
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
}


// MARK: - Preview -

#Preview {
    SearchView()
}
