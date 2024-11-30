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
    func fetchTrendingMovies(page: Int, language: String) async throws -> MovieResult
    
    // https://developer.themoviedb.org/reference/movie-details
    func fetchMovieDetails(id: Int, language: String) async throws -> MovieDetail
    
    // https://developer.themoviedb.org/reference/tv-series-details
    func fetchSeriesDetails(id: Int, language: String) async throws -> SerieDetail
    
    // https://developer.themoviedb.org/reference/search-movie
    func searchForMovies(query: String, page: Int, language: String) async throws -> MovieResult
    
    // https://developer.themoviedb.org/reference/search-tv
    func searchForSeries(query: String, page: Int, language: String) async throws -> SerieResult
    
    // https://developer.themoviedb.org/docs/image-basics
    func fetchImageData(size: ImageSize, path: String, language: String) async throws -> Data
}


// MARK: - MovieDatabaseCore -

public actor MovieDatabaseCore: CoreClientDefining {

    
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
    
    public func fetchTrendingMovies(page: Int, language: String = "en-US") async throws -> MovieResult {
        try await client.fetchTrendingMovies(page: page, language: language)
    }
    
    public func fetchMovieDetails(id: Int, language: String = "en-US") async throws -> MovieDetail {
        try await client.fetchDetails(returnType: MovieDetail.self, id: id, language: language)
    }
    
    public func fetchSeriesDetails(id: Int, language: String = "en-US") async throws -> SerieDetail {
        try await client.fetchDetails(returnType: SerieDetail.self, id: id, language: language)
    }
    
    public func searchForMovies(query: String, page: Int, language: String = "en-US") async throws -> MovieResult {
        try await client.searchFilms(returnType: MovieResult.self, query: query, page: page, language: language)
    }
    
    public func searchForSeries(query: String, page: Int, language: String = "en-US") async throws -> SerieResult {
        try await client.searchFilms(returnType: SerieResult.self, query: query, page: page, language: language)
    }
    
    public func fetchImageData(size: ImageSize, path: String, language: String = "en-US") async throws -> Data {
        try await client.fetchImageData(size: size, path: path, language: language)
    }
    
    
    // MARK: - Internal
    
    private let client = HttpClient()
    
    internal init() {}
}
