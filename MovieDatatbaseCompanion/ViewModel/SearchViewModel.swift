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

    enum SearchType: String, CustomStringConvertible, Equatable {
        case movies = "Movies"
        case series = "Series"

        var description: String {
            self.rawValue
        }
    }


    // MARK: - Properties

    @Published var searchText: String = ""
    @Published var searchType: String = SearchType.movies.rawValue
    @Published @MainActor var state: State = .initial

    private var cancellables = Set<AnyCancellable>()
    private let movieDatabaseCore = MovieDatabaseCore.shared


    // MARK: - Lifecycle

    init() {
        setupObservation()
    }


    // MARK: - API

    func setState(_ newState: State) {
        Task { @MainActor in
            state = newState
        }
    }


    // MARK: - Internal

    private func setupObservation() {
        $searchText
            .debounce(for: .milliseconds(600), scheduler: DispatchQueue.main)
            .sink { [weak self] output in
                guard let self = self else { return }
                search(query: output, of: searchType.asSearchType)
            }
            .store(in: &cancellables)
    }

    private func search(query: String, of type: SearchType) {
        guard !query.isEmpty else { return }
        setState(.loading)

        Task {
            do {
                if type == .movies {
                    let result = try await movieDatabaseCore.searchForMovies(query: query, page: 1)
                    guard !result.results.isEmpty else {
                        setState(.noResults)
                        return
                    }
                    setState(.movieResults(result.results))
                } else {
                    let result = try await movieDatabaseCore.searchForSeries(query: query, page: 1)
                    guard !result.results.isEmpty else {
                        setState(.noResults)
                        return
                    }
                    setState(.seriesResults(result.results))
                }
            } catch {
                print(error)
                setState(.noResults)
            }
        }
    }
}


// MARK: - Extensions -

private extension String {

    var asSearchType: SearchViewModel.SearchType {
        switch self.lowercased() {
        case "movies":
            return .movies
        default:
            return .series
        }
    }
}
