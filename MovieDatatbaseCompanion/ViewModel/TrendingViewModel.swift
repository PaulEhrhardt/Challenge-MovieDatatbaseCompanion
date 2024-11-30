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
        case initial, loading, nextPage
    }
    
    // MARK: - Properties
    
    var state: State = .initial
    var movies: [Movie] = []
    
    @ObservationIgnored var page = 1
    @ObservationIgnored let movieDatabaseCore = MovieDatabaseCore.shared
    
    // MARK: - API
    
    func loadTrendingMovies() async {
        print("Loading page: \(page)")
        state = .loading
        do {
            let result = try await movieDatabaseCore.fetchTrendingMovies(page: page)
            print(result)
            guard !result.results.isEmpty else { return }
            page += 1
            movies.append(contentsOf: result.results)
            state = .nextPage
        } catch {
            print(error)
        }
    }
}
