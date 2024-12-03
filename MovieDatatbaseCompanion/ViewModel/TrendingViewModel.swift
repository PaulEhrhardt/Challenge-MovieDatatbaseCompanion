//
//  TrendingViewModel.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 30/11/24.
//

import Foundation
import Observation
import MovieDatabaseCore


// MARK: - TrendingViewModel -

@Observable
class TrendingViewModel {
    
    
    // MARK: - Types
    
    enum State {
        case initial, loading, nextPage, failure
    }


    // MARK: - Properties
    
    @MainActor var state: State = .initial
    @MainActor var movies: [Movie] = []

    @ObservationIgnored @MainActor var page = 1
    @ObservationIgnored let movieDatabaseCore = MovieDatabaseCore.shared


    // MARK: - API

    func loadTrendingMovies() async {
        setState(.loading)

        Task(priority: .userInitiated) {
            do {
                let result = try await movieDatabaseCore.fetchTrendingMovies(page: page)
                guard !result.results.isEmpty else { return }
                Task { @MainActor in
                    page += 1
                    movies.append(contentsOf: result.results)
                    state = .nextPage
                }
            } catch {
                print(error)
                setState(.failure)
            }
        }
    }


    // MARK: - Innternal

    private func setState(_ newState: State) {
        Task { @MainActor in
            state = newState
        }
    }
}
