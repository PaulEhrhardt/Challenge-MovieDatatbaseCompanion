//
//  SearchViewModel.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 1/12/24.
//

import Foundation
import Combine
import SwiftUI
import MovieDatabaseCore


// MARK: - SearchViewModel -

final class SearchViewModel: ObservableObject {


    // MARK: - Types

    enum State {
        case initial, loading, movieResults([Movie]), seriesResults([Serie]), noResults
    }

    enum SearchType: String, CustomStringConvertible {
        case movies = "Movies"
        case series = "Series"

        var description: String {
            self.rawValue
        }
    }


    // MARK: - Properties

    @Published var searchText: String = ""
    @Published var searchType: String = SearchType.movies.rawValue
    @Published var state: State = .initial

    private var cancellables = Set<AnyCancellable>()
    private let movieDatabaseCore = MovieDatabaseCore.shared


    // MARK: - Lifecycle

    init() {
        setupObservation()
    }


    // MARK: - Internal

    private func setupObservation() {
        $searchText
            .debounce(for: .milliseconds(600), scheduler: DispatchQueue.main)
            .sink { [weak self] output in
                guard let self = self else { return }
          //      search(query: output, of: searchType)
            }
            .store(in: &cancellables)
    }

//    private func search(query: String, of type: SearchType) {
//        guard !query.isEmpty else { return }
//        print(query)
//        state = .loading
//
//        Task {
//            do {
//                if type == .movies {
//                    let result = try await movieDatabaseCore.searchForMovies(query: query, page: 1)
//                    guard !result.results.isEmpty else {
//                        state = .noResults
//                        return
//                    }
//                    state = .movieResults(result.results)
//                } else {
//                    let result = try await movieDatabaseCore.searchForSeries(query: query, page: 1)
//                    guard !result.results.isEmpty else {
//                        state = .noResults
//                        return
//                    }
//                    state = .seriesResults(result.results)
//                }
//            } catch {
//                print(error)
//                state = .noResults
//            }
//        }
//    }
}
