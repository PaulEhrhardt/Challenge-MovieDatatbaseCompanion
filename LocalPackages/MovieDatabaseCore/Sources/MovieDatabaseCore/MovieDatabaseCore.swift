// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation


// MARK: - CoreClientDefining -
 
public protocol CoreClientDefining {
    
    // Current version of this lib
    var version: String { get }
    
    // Determin if API key has been set
    var hasApiKey: Bool { get async }
    
    // Register api key before any interaction with the API
    func registerApiKey(key: String) async
    
    // https://developer.themoviedb.org/reference/trending-movies
    func fetchTrendingMovies(page: Int) async throws -> MovieResult
    
    // https://developer.themoviedb.org/reference/movie-details
    func fetchMovieDetails(id: Int) async throws -> MovieDetail
    
    // https://developer.themoviedb.org/reference/tv-series-details
    func fetchSeriesDetails(id: Int) async throws -> SerieDetail
    
    // https://developer.themoviedb.org/reference/search-movie
    func searchForMovies(query: String) async throws -> MovieResult
    
    // https://developer.themoviedb.org/reference/search-tv
    func searchForSeries(query: String) async throws -> SerieResult
    
    // https://developer.themoviedb.org/docs/image-basics
    func fetchImageData(size: ImageSize, path: String) async throws -> Data
}


// MARK: - MovieDatabaseCore -

public actor MovieDatabaseCore: @preconcurrency CoreClientDefining {

    
    // MARK: - Properties
    
    public static let shared = MovieDatabaseCore()
    
    public nonisolated var version: String {
        "1.0.0"
    }
    
    public var hasApiKey: Bool {
        get async { await client.hasApiKey }
    }
    
    
    // MARK: - API
    
    public func registerApiKey(key: String) async {
        await client.registerApiKey(key: key)
    }
    
    public func fetchTrendingMovies(page: Int) async throws -> MovieResult {
        try await client.fetchTrendingMovies(page: page)
    }
    
    public func fetchMovieDetails(id: Int) async throws -> MovieDetail {
        fatalError("Not Implemented")
    }
    
    public func fetchSeriesDetails(id: Int) async throws -> SerieDetail {
        fatalError("Not Implemented")
    }
    
    public func searchForMovies(query: String) async throws -> MovieResult {
        fatalError("Not Implemented")
    }
    
    public func searchForSeries(query: String) async throws -> SerieResult {
        fatalError("Not Implemented")
    }
    
    public func fetchImageData(size: ImageSize, path: String) async throws -> Data {
        fatalError("Not Implemented")
    }
    
    
    // MARK: - Internal
    
    private let client = HttpClient()
    
    private init() {}
}
